################################################################################
#
# archlinux-keyring
#
################################################################################

ARCHLINUX_KEYRING_VERSION = 20200622
ARCHLINUX_KEYRING_SITE = https://sources.archlinux.org/other/archlinux-keyring
ARCHLINUX_KEYRING_LICENSE = GPL-2.0

define HOST_ARCHLINUX_KEYRING_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) PREFIX=$(HOST_DIR) install
endef

$(eval $(host-generic-package))
