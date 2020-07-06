################################################################################
#
# python3-gpg
#
################################################################################

# Please keep in sync with package/python-gpg/python-gpg.mk
PYTHON3_GPG_VERSION = 1.10.0
PYTHON3_GPG_SOURCE = gpg-$(PYTHON3_GPG_VERSION).tar.gz
PYTHON3_GPG_SITE = https://files.pythonhosted.org/packages/ef/86/c5a34243a932346c59cb25eb49a4d1dec227974209eb9b618d0ed57ea5be
PYTHON3_GPG_SETUP_TYPE = distutils
PYTHON3_GPG_LICENSE = LGPL-2.1+
HOST_PYTHON3_GPG_DL_SUBDIR = python-gpg
HOST_PYTHON3_GPG_NEEDS_HOST_PYTHON = python3
HOST_PYTHON3_GPG_DEPENDENCIES = host-gnupg

$(eval $(host-python-package))
