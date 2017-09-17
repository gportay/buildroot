################################################################################
#
# qtwebbrowser
#
################################################################################

QTWEBBROWSER_VERSION = 2dd93e76e19440f97f79a4d048905e26c01684b6
QTWEBBROWSER_SITE = git://code.qt.io/qt-apps/qtwebbrowser.git

QTWEBBROWSER_LICENSE = GPLv3, FDL
QTWEBBROWSER_LICENSE_FILES = LICENSE.GPLv3 LICENSE.FDL

define QTWEBBROWSER_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake INSTALL_PREFIX=/usr/bin)
endef

define QTWEBBROWSER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QTWEBBROWSER_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install INSTALL_ROOT=$(TARGET_DIR)
endef

$(eval $(generic-package))
