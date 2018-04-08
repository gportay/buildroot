################################################################################
#
# skeleton-debian
#
################################################################################

# The skeleton can't depend on the toolchain, since all packages depends on the
# skeleton and the toolchain is a target package, as is skeleton.
# Hence, skeleton would depends on the toolchain and the toolchain would depend
# on skeleton.
SKELETON_DEBIAN_ADD_TOOLCHAIN_DEPENDENCY = NO
SKELETON_DEBIAN_ADD_SKELETON_DEPENDENCY = NO

SKELETON_DEBIAN_DEPENDENCIES = host-debootstrap host-fakeroot host-fakechroot skeleton-init-common

SKELETON_DEBIAN_PROVIDES = skeleton

ifeq ($(BR2_PACKAGE_SKELETON_DEBIAN_SUITE_STABLE),y)
SKELETON_DEBIAN_DEBOOTSTRAP_SUITE = stable
endif

ifeq ($(BR2_PACKAGE_SKELETON_DEBIAN_SUITE_TESTING),y)
SKELETON_DEBIAN_DEBOOTSTRAP_SUITE = testing
endif

ifeq ($(BR2_PACKAGE_SKELETON_DEBIAN_SUITE_UNSTABLE),y)
SKELETON_DEBIAN_DEBOOTSTRAP_SUITE = unstable
endif

SKELETON_DEBIAN_DEBOOTSTRAP_OPTS = $(call qstrip,$(BR2_PACKAGE_SKELETON_ARCHLINUX_PACKAGES))

ifeq ($(BR2_ROOTFS_MERGED_USR),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --merged-usr
endif

ifeq ($(BR2_i386),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch i386
SKELETON_DEBIAN_QEMU_STATIC = qemu-i386-static
endif

ifeq ($(BR2_x86_64),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch amd64
SKELETON_DEBIAN_QEMU_STATIC = qemu-x64_64-static
endif

ifeq ($(BR2_arm),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch armel
SKELETON_DEBIAN_QEMU_STATIC = qemu-arm-static
endif

ifeq ($(BR2_aarch64),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch arm64
SKELETON_DEBIAN_QEMU_STATIC = qemu-aarch64-static
endif

ifeq ($(BR2_mips),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch mips
SKELETON_DEBIAN_QEMU_STATIC = qemu-mips-static
endif

ifeq ($(BR2_mipsel),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch mipsel
SKELETON_DEBIAN_QEMU_STATIC = qemu-mipsel-static
endif

ifeq ($(BR2_mips64el),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch mips64el
SKELETON_DEBIAN_QEMU_STATIC = qemu-mips64el-static
endif

ifeq ($(BR2_powerpc),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch powerpc
SKELETON_DEBIAN_QEMU_STATIC = qemu-ppc-static
endif

ifeq ($(BR2_powerpc64le),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch ppc64el
SKELETON_DEBIAN_QEMU_STATIC = qemu-ppc64le-static
endif

ifneq ($(ARCH),$(HOSTARCH))
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --foreign

define SKELETON_DEBIAN_INSTALL_QEMU_STATIC
	$(INSTALL) -D /usr/bin/$(SKELETON_DEBIAN_QEMU_STATIC) $(@D)/rootfs/usr/bin/$(SKELETON_DEBIAN_QEMU_STATIC)
endef
SKELETON_DEBIAN_PRE_BUILD_HOOKS += SKELETON_DEBIAN_INSTALL_QEMU_STATIC

define SKELETON_DEBIAN_SECOND_STAGE
	PATH=$(BR_PATH) QEMU_LD_PREFIX=$(@D)/rootfs fakeroot -- fakechroot -- chroot $(@D)/rootfs /debootstrap/debootstrap --second-stage
endef
SKELETON_DEBIAN_POST_BUILD_HOOKS += SKELETON_DEBIAN_SECOND_STAGE

define SKELETON_DEBIAN_REMOVE_QEMU_STATIC
	$(RM) -f $(@D)/rootfs/usr/bin/$(SKELETON_DEBIAN_QEMU_STATIC)
endef
SKELETON_DEBIAN_POST_BUILD_HOOKS += SKELETON_DEBIAN_REMOVE_QEMU_STATIC
endif

SKELETON_DEBIAN_DEBOOTSTRAP_MIRROR = $(call qstrip,$(BR2_PACKAGE_SKELETON_DEBIAN_MIRROR))

define SKELETON_DEBIAN_BUILD_CMDS
	mkdir -p $(@D)/rootfs
	PATH=$(BR_PATH) DEBOOTSTRAP_DIR=$(HOST_DIR)/share/debootstrap fakeroot -- fakechroot -- debootstrap $(SKELETON_DEBIAN_DEBOOTSTRAP_OPTS) $(SKELETON_DEBIAN_DEBOOTSTRAP_SUITE) $(@D)/rootfs $(SKELETON_DEBIAN_DEBOOTSTRAP_MIRROR)
endef

define SKELETON_DEBIAN_INSTALL_TARGET_CMDS
	$(call SYSTEM_RSYNC,$(@D)/rootfs,$(TARGET_DIR))
endef

$(eval $(generic-package))
