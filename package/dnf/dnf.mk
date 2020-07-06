################################################################################
#
# dnf
#
################################################################################

DNF_VERSION = 4.2.23
DNF_SITE = $(call github,rpm-software-management,dnf,$(DNF_VERSION))
DNF_LICENSE = GPL-2.0
DNF_LICENSE_FILES = COPYING

HOST_DNF_DEPENDENCIES = host-bash-completion host-python3 host-python3-gpg host-python3-iniparse host-python3-six

HOST_DNF_CONF_OPTS = \
	-DBASH_COMPLETION_COMPLETIONSDIR=$(HOST_DIR)/share/bash-completion \
	-DPYTHON_DESIRED=3 \
	-DSYSCONFDIR=$(HOST_DIR)/etc \
	-DSYSTEMD_DIR=$(HOST_DIR)/lib/systemd/system/

$(eval $(host-cmake-package))
