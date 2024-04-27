#!/bin/bash

MOGUL_ACTIVATION_ID=$2

S3Bucket='parallelcluster-d1db3a7e7a2cdb9c-v1-do-not-delete'

# patch compute nodes oe license copy
sudo aws s3 cp s3://$S3Bucket/xray-software/openeye/oe_license.txt /opt/openeye
sudo chown -R ubuntu:ubuntu /opt/openeye/oe_license.txt

useradd -m -u 1001 -d /home/jmurray -s /bin/bash jmurray
useradd -m -u 1022 -d /home/jsanders -s /bin/bash jsanders

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

CUDA_INSTALL_PATH=/shared/cuda
CUDA_VERSION=12.4.1
CUDA_LONG_VERSION=12.4.1_550.54.15

# Install CUDA Toolkit
cd "${CUDA_INSTALL_PATH}" || return
sudo wget "https://developer.download.nvidia.com/compute/cuda/${CUDA_VERSION}/local_installers/cuda_${CUDA_LONG_VERSION}_linux.run"
sudo sh cuda_"${CUDA_LONG_VERSION}"_linux.run --defaultroot="${CUDA_INSTALL_PATH}" --toolkit --toolkitpath="${CUDA_INSTALL_PATH}"/"${CUDA_VERSION}" --samples --silent
sudo rm cuda_"${CUDA_LONG_VERSION}"_linux.run

sudo out="/etc/profile.d/cuda.sh" sh -c "cat << EOF > \"\$out\"
\$PATH:${CUDA_INSTALL_PATH}/${CUDA_VERSION}/bin
EOF"
