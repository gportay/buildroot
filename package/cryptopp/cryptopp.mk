################################################################################
#
# cryptopp
#
################################################################################

CRYPTOPP_VERSION = 7.0.0
CRYPTOPP_SOURCE = cryptopp$(subst .,,$(CRYPTOPP_VERSION)).zip
CRYPTOPP_SITE = http://cryptopp.com/
CRYPTOPP_LICENSE = BSL-1.0
CRYPTOPP_LICENSE_FILES = License.txt
CRYPTOPP_INSTALL_STAGING = YES

define CRYPTOPP_EXTRACT_CMDS
	$(UNZIP) $(HOST_CRYPTOPP_DL_DIR)/$(CRYPTOPP_SOURCE) -d $(@D)
endef

define CRYPTOPP_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" shared
endef

define CRYPTOPP_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) PREFIX=/usr DESTDIR=$(STAGING_DIR) install
endef

define CRYPTOPP_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) PREFIX=/usr DESTDIR=$(TARGET_DIR) install
endef

define HOST_CRYPTOPP_EXTRACT_CMDS
	$(UNZIP) $(HOST_CRYPTOPP_DL_DIR)/$(CRYPTOPP_SOURCE) -d $(@D)
endef

HOST_CRYPTOPP_MAKE_OPTS = \
	$(HOST_CONFIGURE_OPTS) \
	CXXFLAGS="$(HOST_CXXFLAGS) -fPIC"

define HOST_CRYPTOPP_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) $(HOST_CRYPTOPP_MAKE_OPTS) shared
endef

define HOST_CRYPTOPP_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) PREFIX=$(HOST_DIR) install
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
