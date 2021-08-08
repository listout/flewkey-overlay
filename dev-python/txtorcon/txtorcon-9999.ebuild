# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/meejah/txtorcon/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/meejah/txtorcon.git"
fi

DESCRIPTION="Tor control protocol implementation for Python"
HOMEPAGE="https://github.com/meejah/txtorcon"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=dev-python/twisted-15.5.0[${PYTHON_USEDEP},crypt]
	>=dev-python/zope-interface-3.6.1[${PYTHON_USEDEP}]
	dev-python/incremental[${PYTHON_USEDEP}]
	dev-python/automat[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
"
BDEPEND=""
