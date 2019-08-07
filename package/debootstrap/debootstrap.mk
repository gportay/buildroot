################################################################################
#
# debootstrap
#
################################################################################

DEBOOTSTRAP_VERSION = 1.0.115
DEBOOTSTRAP_SITE = https://deb.debian.org/debian/pool/main/d/debootstrap/
DEBOOTSTRAP_SOURCE = debootstrap_$(DEBOOTSTRAP_VERSION).tar.gz
DEBOOTSTRAP_LICENSE = MIT
DEBOOTSTRAP_LICENSE_FILES = debian/copyright

define HOST_DEBOOTSTRAP_INSTALL_CMDS
	$(HOST_MAKE_ENV) fakeroot $(MAKE) -C $(@D) DESTDIR=$(HOST_DIR) install
endef

$(eval $(host-generic-package))
