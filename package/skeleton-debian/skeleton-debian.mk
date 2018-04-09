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

SKELETON_DEBIAN_DEPENDENCIES = host-debootstrap host-fakeroot skeleton-init-common

SKELETON_DEBIAN_PROVIDES = skeleton

ifeq ($(BR2_PACKAGE_SKELETON_DEBIAN_SUITE_STABLE),y)
SKELETON_DEBIAN_DEBOOTSTRAP_SUITE = stable
else
ifeq ($(BR2_PACKAGE_SKELETON_DEBIAN_SUITE_TESTING),y)
SKELETON_DEBIAN_DEBOOTSTRAP_SUITE = testing
else
ifeq ($(BR2_PACKAGE_SKELETON_DEBIAN_SUITE_UNSTABLE),y)
SKELETON_DEBIAN_DEBOOTSTRAP_SUITE = unstable
endif
endif
endif

SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --foreign

ifeq ($(BR2_ROOTFS_MERGED_USR),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --merged-usr
endif

ifeq ($(BR2_i386),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch i386
else
ifeq ($(BR2_x86_64),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch amd64
else
ifeq ($(BR2_arm),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch armel
else
ifeq ($(BR2_aarch64),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch arm64
else
ifeq ($(BR2_mips),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch mips
else
ifeq ($(BR2_mipsel),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch mipsel
else
ifeq ($(BR2_mips64el),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch mips64el
else
ifeq ($(BR2_powerpc),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch powerpc
else
ifeq ($(BR2_powerpc64le),y)
SKELETON_DEBIAN_DEBOOTSTRAP_OPTS += --arch ppc64el
endif
endif
endif
endif
endif
endif
endif
endif
endif

define SKELETON_DEBIAN_BUILD_CMDS
	mkdir -p $(@D)/rootfs
	PATH=$(BR_PATH) $(HOST_DIR)/bin/fakeroot -- $(HOST_DIR)/bin/debootstrap $(SKELETON_DEBIAN_DEBOOTSTRAP_OPTS) $(SKELETON_DEBIAN_DEBOOTSTRAP_SUITE) $(@D)/rootfs $(SKELETON_DEBIAN_DEBOOTSTRAP_MIRROR)
endef

define SKELETON_DEBIAN_INSTALL_TARGET_CMDS
	$(call SYSTEM_RSYNC,$(@D)/rootfs,$(TARGET_DIR))
endef

$(eval $(generic-package))
