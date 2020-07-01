################################################################################
#
# archlinuxarm-keyring
#
################################################################################

ARCHLINUXARM_KEYRING_VERSION = 20140119
ARCHLINUXARM_KEYRING_SITE = http://archlinuxarm.org/builder/src
ARCHLINUXARM_KEYRING_LICENSE = GPL-2.0

define HOST_ARCHLINUXARM_KEYRING_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) PREFIX=$(HOST_DIR) install
endef

$(eval $(host-generic-package))
