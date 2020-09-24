################################################################################
#
# skeleton-archlinux
#
################################################################################

# The skeleton can't depend on the toolchain, since all packages depends on the
# skeleton and the toolchain is a target package, as is skeleton.
# Hence, skeleton would depends on the toolchain and the toolchain would depend
# on skeleton.
SKELETON_ARCHLINUX_ADD_TOOLCHAIN_DEPENDENCY = NO
SKELETON_ARCHLINUX_ADD_SKELETON_DEPENDENCY = NO

SKELETON_ARCHLINUX_DEPENDENCIES = host-arch-install-scripts host-archlinux-keyring host-fakechroot host-fakeroot \
				  host-pacman host-pacman-mirrorlist skeleton-init-common 

SKELETON_ARCHLINUX_PROVIDES = skeleton

SKELETON_ARCHLINUX_BIN_ARCH_EXCLUDE = /usr/lib/guile/2.2/site-ccache

SKELETON_ARCHLINUX_KEYRINGS = archlinux
SKELETON_ARCHLINUX_PACKAGES = $(call qstrip,$(BR2_PACKAGE_SKELETON_ARCHLINUX_PACKAGES))

ifeq ($(BR2_aarch64),y)
SKELETON_ARCHLINUX_DEPENDENCIES += host-archlinuxarm-keyring
SKELETON_ARCHLINUX_KEYRINGS += archlinuxarm
endif

ifneq ($(ARCH),$(HOSTARCH))
ifeq ($(BR2_x86_64),y)
SKELETON_ARCHLINUX_QEMU_STATIC = qemu-x64_64-static
endif

ifeq ($(BR2_aarch64),y)
SKELETON_ARCHLINUX_QEMU_STATIC = qemu-aarch64-static
endif

ifdef SKELETON_ARCHLINUX_QEMU_STATIC
define SKELETON_ARCHLINUX_INSTALL_QEMU_STATIC
	$(INSTALL) -D /usr/bin/$(SKELETON_ARCHLINUX_QEMU_STATIC) $(@D)/rootfs/usr/bin/$(SKELETON_ARCHLINUX_QEMU_STATIC)
endef
SKELETON_ARCHLINUX_PRE_BUILD_HOOKS += SKELETON_ARCHLINUX_INSTALL_QEMU_STATIC

define SKELETON_ARCHLINUX_REMOVE_QEMU_STATIC
	$(RM) -f $(@D)/rootfs/usr/bin/$(SKELETON_ARCHLINUX_QEMU_STATIC)
endef
SKELETON_ARCHLINUX_POST_BUILD_HOOKS += SKELETON_ARCHLINUX_REMOVE_QEMU_STATIC
endif
endif

define SKELETON_ARCHLINUX_BUILD_CMDS
	mkdir -p $(@D)/rootfs/
	$(INSTALL) -D -m 0644 $(SKELETON_ARCHLINUX_PKGDIR)/pacman.conf $(@D)/pacman.conf
	EUID=0 PATH=$(BR_PATH) pacman-key --init
	EUID=0 PATH=$(BR_PATH) pacman-key --populate $(SKELETON_ARCHLINUX_KEYRINGS)
	mkdir -p $(@D)/rootfs/etc/pacman.d/
	cp -a $(HOST_DIR)/etc/pacman.d/gnupg $(@D)/rootfs/etc/pacman.d/
	cp -a $(HOST_DIR)/etc/pacman.d/mirrorlist $(@D)/
	( cd $(@D) && PATH=$(BR_PATH) QEMU_LD_PREFIX=$(@D)/rootfs fakeroot -- fakechroot -- pacstrap -GMC $(@D)/pacman.conf rootfs $(SKELETON_ARCHLINUX_PACKAGES) --gpgdir $(@D)/rootfs/etc/pacman.d/gnupg --dbpath $(@D)/rootfs/var/lib/pacman --arch $(ARCH) )
endef

define SKELETON_ARCHLINUX_INSTALL_TARGET_CMDS
	$(call SYSTEM_RSYNC,$(@D)/rootfs,$(TARGET_DIR))
endef

$(eval $(generic-package))
