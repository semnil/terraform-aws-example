Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-boothook; charset="us-ascii"

# Install nfs-utils wget docker-volume-netshare
cloud-init-per once yum_update yum update -y
cloud-init-per once install_nfs_utils_and_wget yum install -y nfs-utils wget
cloud-init-per once wget_docker-volume-netshare wget https://github.com/ContainX/docker-volume-netshare/releases/download/v0.35/docker-volume-netshare_0.35_linux_amd64-bin -O /usr/bin/docker-volume-netshare
cloud-init-per once chmod_docker-volume-netshare chmod 755 /usr/bin/docker-volume-netshare
cloud-init-per once start_docker-volume-netshare_daemon /usr/bin/docker-volume-netshare efs >> /var/log/docker-volume-netshare.log 2>&1 &
--//
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
cat << EOF >> /etc/ecs/ecs.config
ECS_CLUSTER=${cluster}
ECS_ENABLE_SPOT_INSTANCE_DRAINING=true
EOF
cd /tmp
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl start amazon-ssm-agent
--//
