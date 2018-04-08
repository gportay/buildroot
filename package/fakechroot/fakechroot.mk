################################################################################
#
# fakechroot
#
################################################################################

FAKECHROOT_VERSION = 2.19
FAKECHROOT_SITE = $(call github,dex4er,fakechroot,$(FAKECHROOT_VERSION))
FAKECHROOT_LICENSE = LGPL-2.1+
FAKECHROOT_LICENSE_FILES = LICENSE COPYING

$(eval $(host-autotools-package))
