#!/bin/bash

set -ouex pipefail

# Remove fedora-release packages (with nodeps), then immeidately install the mariner replacement
rpm -e $(rpm -qa | grep fedora-release-) --nodeps
rpm -i https://packages.microsoft.com/yumrepos/azurelinux-3.0-prod-base-x86_64/Packages/a/azurelinux-release-3.0-25.azl3.noarch.rpm

dnf5 -y update
