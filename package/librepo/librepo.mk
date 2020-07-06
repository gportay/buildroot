################################################################################
#
# librepo
#
################################################################################

LIBREPO_VERSION = 1.12.0
LIBREPO_SITE = $(call github,rpm-software-management,librepo,$(LIBREPO_VERSION))
LIBREPO_LICENSE = LGPL-2.0
LIBREPO_LICENSE_FILES = COPYING

HOST_LIBREPO_DEPENDENCIES = host-libglib2 host-libxml2 host-openssl host-zchunk

HOST_LIBREPO_CONF_OPTS = \
	-DENABLE_DOCS=OFF \
	-DENABLE_TESTS=OFF \
	-DPYTHON_DESIRED=3 \
	-DWITH_ZCHUNK=ON

$(eval $(host-cmake-package))
