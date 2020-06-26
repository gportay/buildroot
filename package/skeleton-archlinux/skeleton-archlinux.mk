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

export http_proxy=http://localhost:3142

define SKELETON_ARCHLINUX_BUILD_CMDS
	mkdir -p $(@D)/rootfs
	$(INSTALL) -D -m 0644 $(SKELETON_ARCHLINUX_PKGDIR)/pacman.conf $(@D)/pacman.conf
	$(INSTALL) -D -m 0644 $(SKELETON_ARCHLINUX_PKGDIR)/mirrorlist-$(ARCH) $(@D)/mirrorlist
	( cd $(@D) && PATH=$(BR_PATH) fakeroot -- fakechroot -- pacstrap -GMC pacman.conf rootfs base archlinuxarm-keyring )
	( cd $(@D) && PATH=$(BR_PATH) fakeroot -- fakechroot -- arch-chroot rootfs bash -c "pacman-key --init && pacman-key --populate archlinux" )
endef

define SKELETON_ARCHLINUX_INSTALL_TARGET_CMDS
	$(call SYSTEM_RSYNC,$(@D)/rootfs,$(TARGET_DIR))
endef

$(eval $(generic-package))
