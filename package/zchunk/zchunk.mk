################################################################################
#
# zchunk
#
################################################################################

ZCHUNK_VERSION = 1.1.6
ZCHUNK_SITE = $(call github,zchunk,zchunk,$(ZCHUNK_VERSION))
ZCHUNK_LICENSE = BSD-2-Clause
ZCHUNK_LICENSE_FILES = LICENSE

HOST_ZCHUNK_DEPENDENCIES = host-libcurl host-openssl host-zstd

HOST_ZCHUNK_CONF_OPTS = \
	-Dcoverity=false \
	-Dwith-openssl=enabled \
	-Dwith-zstd=enabled

$(eval $(host-meson-package))
