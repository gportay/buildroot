################################################################################
#
# python-gnupg
#
################################################################################

# Please keep in sync with package/python-gnupg/python-gnupg.mk
PYTHON_GNUPG_VERSION = 0.4.6
PYTHON_GNUPG_SOURCE = python-gnupg-$(PYTHON_GNUPG_VERSION).tar.gz
PYTHON_GNUPG_SITE = https://files.pythonhosted.org/packages/4c/77/6ad0b942deddd9f8246cad7985c6c69e4b1f849c7ec333503fba3b418096
PYTHON_GNUPG_SETUP_TYPE = setuptools
PYTHON_GNUPG_LICENSE = Apache-2.0
PYTHON_GNUPG_LICENSE_FILES = LICENSE.txt
HOST_PYTHON_GNUPG_DL_SUBDIR = python-gnupg
HOST_PYTHON_GNUPG_NEEDS_HOST_PYTHON = python3
HOST_PYTHON_GNUPG_DEPENDENCIES = host-gnupg

$(eval $(host-python-package))
