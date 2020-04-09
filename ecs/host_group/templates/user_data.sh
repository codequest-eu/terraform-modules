#!/bin/bash
echo ECS_CLUSTER=${cluster_name} >> /etc/ecs/ecs.config

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
*${detailed_monitoring ? "" : "/5"} * * * * ec2-user /opt/aws-scripts-mon/mon-put-instance-data.pl --from-cron --mem-util --mem-used --mem-avail --swap-util --swap-used
*${detailed_monitoring ? "" : "/5"} * * * * ec2-user /opt/aws-scripts-mon/mon-put-instance-data.pl --from-cron --disk-path=/ --disk-space-util --disk-space-used --disk-space-avail
EOF
