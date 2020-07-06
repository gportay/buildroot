################################################################################
#
# libcomps
#
################################################################################

LIBCOMPS_VERSION = 0.1.15
LIBCOMPS_SITE = $(call github,rpm-software-management,libcomps,libcomps-$(LIBCOMPS_VERSION))
LIBCOMPS_LICENSE = GPL-2.0
LIBCOMPS_LICENSE_FILES = COPYING

HOST_LIBCOMPS_DEPENDENCIES = host-expat host-libxml2 host-zlib

HOST_LIBCOMPS_SUBDIR = libcomps
HOST_LIBCOMPS_CONF_OPTS = \
	-DENABLE_DOCS=OFF \
	-DENABLE_TESTS=OFF \
	-DPYTHON_DESIRED=3

$(eval $(host-cmake-package))
