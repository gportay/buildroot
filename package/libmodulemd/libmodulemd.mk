################################################################################
#
# libmodulemd
#
################################################################################

LIBMODULEMD_VERSION = 2.9.4
LIBMODULEMD_SITE = $(call github,fedora-modularity,libmodulemd,libmodulemd-$(LIBMODULEMD_VERSION))
LIBMODULEMD_LICENSE = LGPL-2.1
LIBMODULEMD_LICENSE_FILES = COPYING

HOST_LIBMODULEMD_DEPENDENCIES = host-libyaml host-rpm host-libglib2 host-python-gobject

HOST_LIBMODULEMD_CONF_OPTS = \
	-Ddeveloper_build=false \
	-Dlibmagic=disabled \
	-Dpython_name=python3 \
	-Drpmio=disabled \
	-Dskip_formatters=true \
	-Dskip_introspection=true \
	-Dtest_dirty_git=false \
	-Dtest_installed_lib=false \
	-Dwith_docs=false \
	-Dwith_manpages=disabled \
	-Dwith_py2=false

$(eval $(host-meson-package))
