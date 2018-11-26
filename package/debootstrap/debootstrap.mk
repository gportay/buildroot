################################################################################
#
# debootstrap
#
################################################################################

DEBOOTSTRAP_VERSION = 1.0.110
DEBOOTSTRAP_SOURCE = debootstrap-$(DEBOOTSTRAP_VERSION).tar.gz
DEBOOTSTRAP_SITE = https://salsa.debian.org/installer-team/debootstrap/-/archive/$(DEBOOTSTRAP_VERSION)
DEBOOTSTRAP_LICENSE = MIT
DEBOOTSTRAP_LICENSE_FILES = debian/copyright

define HOST_DEBOOTSTRAP_INSTALL_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) DESTDIR="$(TARGET_DIR)" -C $(@D) install
endef

define HOST_DEBOOTSTRAP_INSTALL_CMDS
	$(INSTALL) -d -m 0755 $(HOST_DIR)/bin/ $(HOST_DIR)/share/debootstrap/scripts
	cp -a $(@D)/scripts/* $(HOST_DIR)/share/debootstrap/scripts/
	$(INSTALL) -m 0644 $(@D)/functions $(HOST_DIR)/share/debootstrap/
	VERSION=$$(sed 's/.*(\(.*\)).*/\1/; q' $(@D)/debian/changelog); \
	sed "s/@VERSION@/$$VERSION/g" $(@D)/debootstrap >$(HOST_DIR)/bin/debootstrap
	chmod 0755 $(HOST_DIR)/bin/debootstrap
	sed -e "s,/usr/share/debootstrap,$(HOST_DIR)/share/debootstrap,g" \
	    -i $(HOST_DIR)/share/debootstrap/scripts/* $(HOST_DIR)/bin/debootstrap
endef

$(eval $(host-generic-package))
