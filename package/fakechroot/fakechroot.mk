################################################################################
#
# fakechroot
#
################################################################################

FAKECHROOT_VERSION = 2.20.1
FAKECHROOT_SITE = $(call github,dex4er,fakechroot,$(FAKECHROOT_VERSION))
FAKECHROOT_LICENSE = LGPL-2.1+
FAKECHROOT_LICENSE_FILES = LICENSE COPYING

define HOST_FAKECHROOT_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) install -C $(@D)
	$(INSTALL) -D -m644 $(HOST_FAKECHROOT_PKGDIR)/pacstrap.env $(HOST_DIR)/etc/fakechroot/pacstrap.env
	$(INSTALL) -D -m644 $(HOST_FAKECHROOT_PKGDIR)/arch-chroot.env $(HOST_DIR)/etc/fakechroot/arch-chroot.env
	$(SED) 's,/usr/local,$(HOST_DIR),' $(HOST_DIR)/etc/fakechroot/pacstrap.env
	$(INSTALL) -D -m644 $(HOST_FAKECHROOT_PKGDIR)/dnf.env $(HOST_DIR)/etc/fakechroot/dnf.env
	$(LN) -sf dnf.env $(HOST_DIR)/etc/fakechroot/dnf-3.env
endef

$(eval $(host-autotools-package))
