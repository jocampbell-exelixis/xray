#!/bin/bash

MOGUL_ACTIVATION_ID=$2

S3Bucket='parallelcluster-d1db3a7e7a2cdb9c-v1-do-not-delete'

# patch compute nodes oe license copy
sudo aws s3 cp s3://$S3Bucket/xray-software/openeye/oe_license.txt /opt/openeye
sudo chown -R ubuntu:ubuntu /opt/openeye/oe_license.txt

sudo groupadd -g 1001 jmurray
sudo groupadd -g 1022 jsanders

sudo useradd -m -u 1022 -g 1022 -d /home/jmurray -s /bin/bash jmurray
sudo useradd -m -u 1021 -g 1021 -d /home/dgurbani -s /bin/bash dgurbani
sudo useradd -m -u 1022 -g 1022 -d /home/jsanders -s /bin/bash jsanders

# Customize for Global Phasing
echo "Setting up Global Phasing Software..."
echo 'source /opt/ccp4/ccp4-8.0/bin/ccp4.setup-sh' >> /home/slurm/.profile
echo 'source /opt/GPhL/ALL_snapshot_20230222/setup.sh' >> /home/slurm/.profile
echo 'export PATH="/opt/xds/XDS-INTEL64_Linux_x86_64:$PATH"' >> /home/slurm/.profile
echo 'export BDG_TOOL_MOGUL=/opt/csds/CSD_2022/bin/mogul' >> /home/slurm/.profile
echo 'source /opt/hkl/HKL2000_v722-Linux-x86_64/hkl_setup.sh' >> /home/slurm/.profile
echo 'source /usr/local/phenix-1.20.1-4487/phenix_env.sh' >> /home/slurm/.profile
export PATH="/opt/pymol/pymol/bin:$PATH"
export BDG_TOOL_MOGUL=/opt/csds/CSD_2022/bin/mogul
export PATH="/opt/xds/XDS-INTEL64_Linux_x86_64:$PATH"
source /opt/GPhL/ALL_snapshot_20230222/setup.sh
source /opt/ccp4/ccp4-8.0/bin/ccp4.setup-sh
source /opt/hkl/HKL2000_v722-Linux-x86_64/hkl_setup.sh
source /usr/local/phenix-1.20.1-4487/phenix_env.sh
echo "Completed setup of Global Phasing Software!"
