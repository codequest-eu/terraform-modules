#!/bin/bash
echo ECS_CLUSTER=${cluster_name} >> /etc/ecs/ecs.config

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

# Enable docker daemon live restore, so we can update docker without
# restarting containers
# https://docs.docker.com/config/containers/live-restore/
cat >/etc/docker/daemon.json <<EOF
{
  "live-restore": true
}
EOF

systemctl enable yum-cron
systemctl start yum-cron

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
