#!/bin/bash

set -ouex pipefail

# Remove fedora-release packages (with nodeps), then immeidately install the mariner replacement
rpm -e $(rpm -qa | grep fedora-) --nodeps
rpm -i https://packages.microsoft.com/yumrepos/azurelinux-3.0-prod-base-x86_64/Packages/a/azurelinux-release-3.0-25.azl3.noarch.rpm

dnf5 -y install \
	azurelinux-repos \
	azurelinux-repos-amd \
	azurelinux-repos-extended \
	azurelinux-repos-ms-non-oss \
	azurelinux-repos-ms-oss \
	azurelinux-repos-shared \
	azurelinux-rpm-macros \
	azurelinux-sysinfo \
	azure-nvme \
	azure-storage-cpp

dnf5 -y update
