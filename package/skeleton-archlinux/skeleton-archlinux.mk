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

SKELETON_ARCHLINUX_DEPENDENCIES = host-arch-install-scripts host-fakeroot host-fakechroot skeleton-init-common

SKELETON_ARCHLINUX_PROVIDES = skeleton

ifeq ($(BR2_i386),y)
SKELETON_ARCHLINUX_QEMU_STATIC = qemu-i386-static
endif

ifeq ($(BR2_x86_64),y)
SKELETON_ARCHLINUX_QEMU_STATIC = qemu-x64_64-static
endif

ifeq ($(BR2_arm),y)
SKELETON_ARCHLINUX_QEMU_STATIC = qemu-arm-static
endif

ifeq ($(BR2_aarch64),y)
SKELETON_ARCHLINUX_QEMU_STATIC = qemu-aarch64-static
endif

ifeq ($(BR2_mips),y)
SKELETON_ARCHLINUX_QEMU_STATIC = qemu-mips-static
endif

ifeq ($(BR2_mipsel),y)
SKELETON_ARCHLINUX_QEMU_STATIC = qemu-mipsel-static
endif

ifeq ($(BR2_mips64el),y)
SKELETON_ARCHLINUX_QEMU_STATIC = qemu-i386-static
endif

ifeq ($(BR2_powerpc),y)
SKELETON_ARCHLINUX_QEMU_STATIC = qemu-ppc-static
endif

ifeq ($(BR2_powerpc64le),y)
SKELETON_ARCHLINUX_QEMU_STATIC = qemu-ppc64le-static
endif

export http_proxy=http://localhost:3142
export QEMU_LD_PREFIX=$(SKELETON_ARCHLINUX_PKGDIR)

define SKELETON_ARCHLINUX_BUILD_CMDS
	mkdir -p $(@D)/rootfs
	#$(INSTALL) -D $(HOST_DIR)/bin/$(SKELETON_ARCHLINUX_QEMU_STATIC) $(@D)/rootfs/usr/bin/$(SKELETON_ARCHLINUX_QEMU_STATIC)
	$(INSTALL) -D /usr/bin/$(SKELETON_ARCHLINUX_QEMU_STATIC) $(@D)/rootfs/usr/bin/$(SKELETON_ARCHLINUX_QEMU_STATIC)
	$(INSTALL) -D -m 0644 $(SKELETON_ARCHLINUX_PKGDIR)/pacman.conf $(@D)/pacman.conf
	$(INSTALL) -D -m 0644 $(SKELETON_ARCHLINUX_PKGDIR)/mirrorlist-$(ARCH) $(@D)/mirrorlist
	( cd $(@D) && PATH=$(BR_PATH) QEMU_LD_PREFIX=$(@D)/rootfs fakeroot -- fakechroot -- pacstrap -GMC pacman.conf rootfs base archlinuxarm-keyring )
	( cd $(@D) && PATH=$(BR_PATH) QEMU_LD_PREFIX=$(@D)/rootfs fakeroot -- fakechroot -- arch-chroot rootfs pacman -Qe )
	#( cd $(@D) && PATH=$(BR_PATH) QEMU_LD_PREFIX=$(@D)/rootfs fakeroot -- fakechroot -- arch-chroot rootfs bash -c "pacman-key --init && pacman-key --populate archlinuxarm" )
endef

define SKELETON_ARCHLINUX_INSTALL_TARGET_CMDS
	$(call SYSTEM_RSYNC,$(@D)/rootfs,$(TARGET_DIR))
endef

$(eval $(generic-package))
