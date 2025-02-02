# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Evidlo/markdown_captions.git"
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Image captions for python-markdown"
HOMEPAGE="https://github.com/Evidlo/markdown_captions"
LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="dev-python/markdown"
BDEPEND=""
