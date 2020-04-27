#!/bin/bash

# Log executed commands so it's easier to debug script failures
set -x

instance_id=$(ec2-metadata -i | sed -r 's/instance-id: //')

cat >/etc/ecs/ecs.config <<EOF
ECS_CLUSTER=${cluster_name}

# Speed up stopped container removal, defaults to 3h.
# Long wait duration can lead to the disk being filled up with instances
# of a broken container that gets restarted over and over again.
ECS_ENGINE_TASK_CLEANUP_WAIT_DURATION=5m

# Reserve 256MiB for system processes to minimize the chance of tasks/containers
# overflowing the instance and killing critical processes and the whole
# instance along with them
ECS_RESERVED_MEMORY=256

${ecs_agent_config}
EOF

# Update ECS agent
yum update -y ecs-init
docker pull amazon/amazon-ecs-agent:latest

# Keep the ECS agent up to date
cat >/etc/cron.daily/ecs-agent-update <<EOF
#!/bin/sh
{
  date
  yum update -y ecs-init
  docker pull amazon/amazon-ecs-agent:latest
  systemctl restart ecs
} >>/var/log/ecs/ecs-init-update.log 2>&1
EOF
chmod +x /etc/cron.daily/ecs-agent-update

# Install security updates
yum update -y --security

# Install yum-cron to automate security updates
yum install -y yum-cron

# Setup daily security updates
# Exclude:
# - kernel - requires rebooting to take effect, at which point we might
#            as well create a new instance
cat >/etc/yum/yum-cron.conf <<EOF
[commands]
update_cmd = security
update_messages = yes
download_updates = yes
apply_updates = yes
random_sleep = 0

[base]
exclude = kernel*
EOF

# disable hourly updates
cat >/etc/yum/yum-cron-hourly.conf <<EOF
[commands]
update_cmd = security
update_messages = no
download_updates = no
apply_updates = no
random_sleep = 0
EOF

systemctl enable yum-cron

# Enable docker daemon live restore, so we can update docker without
# restarting containers
# https://docs.docker.com/config/containers/live-restore/
cat >/etc/docker/daemon.json <<EOF
{
  "live-restore": true
}
EOF

# Setup memory and disk usage monitoring
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mon-scripts.html
yum install -y \
  unzip \
  curl \
  perl-Switch \
  perl-DateTime \
  perl-Sys-Syslog \
  perl-LWP-Protocol-https \
  perl-Digest-SHA.x86_64

cd /opt
curl https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip -O
unzip CloudWatchMonitoringScripts-1.2.2.zip && \
rm CloudWatchMonitoringScripts-1.2.2.zip

cat >/etc/cron.d/ec2_metrics <<EOF
*${detailed_monitoring ? "" : "/5"} * * * * ec2-user /opt/aws-scripts-mon/mon-put-instance-data.pl --from-cron --auto-scaling --mem-util --mem-used --mem-avail --swap-util --swap-used
*${detailed_monitoring ? "" : "/5"} * * * * ec2-user /opt/aws-scripts-mon/mon-put-instance-data.pl --from-cron --auto-scaling --disk-path=/ --disk-space-util --disk-space-used --disk-space-avail
EOF

# Setup SSH login banner message and bash prompt

amazon-linux-extras install -y epel && yum install -y figlet
cat >/etc/update-motd.d/40-project-environment <<EOF
#!/bin/sh
echo -e '$(figlet -c -f slant "${project}")'
printf '\033[${environment_color}m'
echo -e '$(figlet -c -f term "${environment} environment")'
printf '\033[m'
echo -e '$(figlet -c -f term "${name} group")'
echo
EOF
yum remove -y figlet epel-release
chmod +x /etc/update-motd.d/40-project-environment
/usr/sbin/update-motd

cat >>/home/ec2-user/.bashrc <<EOF
export PS1="\u@$instance_id ${project} \033[${environment_color}m${environment}\033[m\n\w \$ "
EOF

${user_data}

systemctl start yum-cron
systemctl restart docker

# HACK:
# For some reason simply doing docker pull amazon/amazon-ecs-agent:latest
# in the user data script doesn't fully update the ECS agent, so
# lets force running the daily script once ECS starts up
nohup sh -c 'while ! systemctl is-active -q ecs; do sleep 5; done; /etc/cron.daily/ecs-agent-update' &
