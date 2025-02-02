# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/numba/llvmlite.git"
else
	SRC_URI="https://github.com/numba/llvmlite/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Lightweight LLVM bindings for Python"
HOMEPAGE="https://llvmlite.pydata.org/"
LICENSE="BSD-2"
SLOT="0"
RESTRICT="test"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="sys-devel/llvm:13"

PATCHES=(
	"${FILESDIR}/${P}-llvm12.patch"
	"${FILESDIR}/${P}-allow-py3.11.patch"
)

python_compile() {
	export "LLVM_CONFIG=${EPREFIX}/usr/lib/llvm/13/bin/llvm-config"
	distutils-r1_python_compile
}
