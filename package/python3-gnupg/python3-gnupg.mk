################################################################################
#
# python3-gnupg
#
################################################################################

# Please keep in sync with package/python3-gnupg/python3-gnupg.mk
PYTHON3_GNUPG_VERSION = 0.4.6
PYTHON3_GNUPG_SOURCE = python-gnupg-$(PYTHON3_GNUPG_VERSION).tar.gz
PYTHON3_GNUPG_SITE = https://files.pythonhosted.org/packages/4c/77/6ad0b942deddd9f8246cad7985c6c69e4b1f849c7ec333503fba3b418096
PYTHON3_GNUPG_SETUP_TYPE = setuptools
PYTHON3_GNUPG_LICENSE = Apache-2.0
PYTHON3_GNUPG_LICENSE_FILES = LICENSE.txt
HOST_PYTHON3_GNUPG_DL_SUBDIR = python-gnupg
HOST_PYTHON3_GNUPG_NEEDS_HOST_PYTHON = python3
HOST_PYTHON3_GNUPG_DEPENDENCIES = host-gnupg

$(eval $(host-python-package))
