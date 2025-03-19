#!/bin/bash

set -ouex pipefail

# Remove fedora-release packages (with nodeps), then immeidately install the mariner replacement
rpm -ev $(rpm -qa | grep ^fedora-) --nodeps
rpm -iv https://packages.microsoft.com/yumrepos/azurelinux-3.0-prod-base-x86_64/Packages/a/azurelinux-release-3.0-25.azl3.noarch.rpm

# Install Azure Linux packages/repositories
# Note that some cannot be installed due to bzip2 versioning differences breaking bootc at this time.
dnf -y install \
	azurelinux-repos \
	azurelinux-repos-amd \
	azurelinux-repos-extended \
	azurelinux-repos-ms-non-oss \
	azurelinux-repos-ms-oss \
	azurelinux-repos-shared \
	azurelinux-rpm-macros \
	azurelinux-sysinfo

# Install Azure Linux kernel
dnf -y remove --noautoremove \
	kernel \
	kernel-core \
	kernel-modules \
	kernel-modules-core \
	kernel-modules-extra

dnf -y install \
	kernel \
	kernel-drivers-gpu \
	kernel-drivers-intree-amdgpu \
	kernel-drivers-sound \
	kernel-drivers-accessibility \
	kernel-uki \
	kernel-uvm

# Rebuild initramfs
QUALIFIED_KERNEL="$(dnf repoquery --installed --qf '%{evr}' "kernel")"
/usr/bin/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible --zstd -v --add ostree -f "/usr/lib/modules/$QUALIFIED_KERNEL/initramfs.img"

chmod 0600 /usr/lib/modules/"$QUALIFIED_KERNEL"/initramfs.img