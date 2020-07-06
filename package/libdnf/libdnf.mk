################################################################################
#
# libdnf
#
################################################################################

LIBDNF_VERSION = 0.48.0
LIBDNF_SITE = $(call github,rpm-software-management,libdnf,$(LIBDNF_VERSION))
LIBDNF_LICENSE = LGPL-2.1
LIBDNF_LICENSE_FILES = COPYING

HOST_LIBDNF_DEPENDENCIES = host-check host-cppunit host-json-c host-libmodulemd host-librepo host-libsolv host-openssl host-zchunk

HOST_LIBDNF_CONF_OPTS = \
	-DENABLE_DOCS=OFF \
	-DENABLE_RHSM_SUPPORT=OFF \
	-DENABLE_SOLV_URPMREORDER=OFF \
	-DENABLE_TESTS=OFF \
	-DPYTHON_DESIRED=3 \
	-DWITH_BINDINGS=ON \
	-DWITH_GTKDOC=OFF \
	-DWITH_HTML=OFF \
	-DWITH_MAN=OFF \
	-DWITH_ZCHUNK=ON

define HOST_DNF_PROVIDE_LIBSOLV_CMAKE_MODULE
	ln -f $(HOST_DIR)/share/cmake/Modules/FindLibSolv.cmake $(@D)/cmake/modules/
endef
HOST_LIBDNF_PRE_CONFIGURE_HOOKS += HOST_DNF_PROVIDE_LIBSOLV_CMAKE_MODULE

$(eval $(host-cmake-package))
