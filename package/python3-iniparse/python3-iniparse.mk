################################################################################
#
# python3-iniparse
#
################################################################################

# Please keep in sync with package/python-iniparse/python-iniparse.mk
PYTHON3_INIPARSE_VERSION = 0.5
PYTHON3_INIPARSE_SOURCE = iniparse-$(PYTHON3_INIPARSE_VERSION).tar.gz
PYTHON3_INIPARSE_SITE = https://pypi.python.org/packages/source/i/iniparse
PYTHON3_INIPARSE_LICENSE = Python-2.0, MIT
PYTHON3_INIPARSE_LICENSE_FILES = LICENSE-PSF LICENSE
PYTHON3_INIPARSE_SETUP_TYPE = setuptools
HOST_PYTHON3_INIPARSE_NEEDS_HOST_PYTHON = python3

$(eval $(python-package))
