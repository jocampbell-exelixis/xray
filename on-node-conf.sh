#!/bin/bash

MOGUL_ACTIVATION_ID=$2

useradd -m -u 1001 -d /home/jmurray -s /bin/bash jmurray

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
