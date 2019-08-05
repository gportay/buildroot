################################################################################
#
# skeleton-fedora
#
################################################################################

# The skeleton can't depend on the toolchain, since all packages depends on the
# skeleton and the toolchain is a target package, as is skeleton.
# Hence, skeleton would depends on the toolchain and the toolchain would depend
# on skeleton.
SKELETON_FEDORA_ADD_TOOLCHAIN_DEPENDENCY = NO
SKELETON_FEDORA_ADD_SKELETON_DEPENDENCY = NO

SKELETON_FEDORA_DEPENDENCIES = host-fakeroot host-fakechroot skeleton-init-common

SKELETON_FEDORA_PROVIDES = skeleton

SKELETON_FEDORA_DEPENDENCIES += host-dnf host-libcomps host-libdnf host-librepo
SKELETON_FEDORA_GROUP = $(call qstrip,$(BR2_PACKAGE_SKELETON_FEDORA_GROUP))
SKELETON_FEDORA_RELEASE_VERSION = $(call qstrip,$(BR2_PACKAGE_SKELETON_FEDORA_RELEASE_VERSION))
SKELETON_FEDORA_DNF_OPTS = $(call qstrip,$(BR2_PACKAGE_SKELETON_FEDORA_DNF_ARGS))
SKELETON_FEDORA_DNF_OPTS += --releasever=$(SKELETON_FEDORA_RELEASE_VERSION) --assumeyes

ifneq ($(ARCH),$(HOSTARCH))
SKELETON_FEDORA_DNF_OPTS += --forcearch=$(ARCH)

ifeq ($(BR2_x86_64),y)
SKELETON_FEDORA_QEMU_STATIC = qemu-x64_64-static
endif

ifeq ($(BR2_aarch64),y)
SKELETON_FEDORA_QEMU_STATIC = qemu-aarch64-static
endif

ifdef SKELETON_FEDORA_QEMU_STATIC
define SKELETON_FEDORA_INSTALL_QEMU_STATIC
	$(INSTALL) -D /usr/bin/$(SKELETON_FEDORA_QEMU_STATIC) $(@D)/rootfs/usr/bin/$(SKELETON_FEDORA_QEMU_STATIC)
endef
SKELETON_FEDORA_PRE_BUILD_HOOKS += SKELETON_FEDORA_INSTALL_QEMU_STATIC

define SKELETON_FEDORA_REMOVE_QEMU_STATIC
	$(RM) -f $(@D)/rootfs/usr/bin/$(SKELETON_FEDORA_QEMU_STATIC)
endef
SKELETON_FEDORA_POST_BUILD_HOOKS += SKELETON_FEDORA_REMOVE_QEMU_STATIC
endif
endif

define SKELETON_FEDORA_BUILD_CMDS
	$(INSTALL) -D -m 0644 $(SKELETON_FEDORA_PKGDIR)/fedora.repo $(@D)/rootfs/etc/distro.repos.d/fedora.repo
	( cd $(@D) && PATH=$(BR_PATH) QEMU_LD_PREFIX=$(@D)/rootfs fakeroot -- fakechroot -- dnf-3 $(SKELETON_FEDORA_DNF_OPTS) --installroot=$(@D)/rootfs group install "$(SKELETON_FEDORA_GROUP)" )
	$(RM) -f $(@D)/rootfs/etc/distro.repos.d/fedora.repo
endef

define SKELETON_FEDORA_INSTALL_TARGET_CMDS
	# FIXME: Workaround for cachedir as the host directory is prepended to the variable state information directory of rpm (/var/lib/rpm).
	# TODO: Find out if this is possible to overwrite that directory thanks dnf (command-line or conf-file or env-var).
	if [ -d $(@D)/rootfs/$(HOST_DIR) ]; then \
		rsync -av $(@D)/rootfs/$(HOST_DIR)/. $(@D)/rootfs/.; \
		$(RM) -Rf $(@D)/rootfs/$(HOST_DIR)/
	fi
	$(RM) -Rf $(@D)/rootfs/$(CURDIR)/
	$(RM) -Rf $(@D)/rootfs/$(HOME)/
	$(call SYSTEM_RSYNC,$(@D)/rootfs,$(TARGET_DIR))
endef

$(eval $(generic-package))