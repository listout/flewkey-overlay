# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} != *9999* ]]; then
	MY_PN="libShake"
	MY_P="${MY_PN}-${PV}"
	S="${WORKDIR}/${MY_P}"
	SRC_URI="https://github.com/zear/${MY_PN}/archive/refs/tags/v${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/zear/libShake.git"
fi

DESCRIPTION="Simple, cross-platform haptic library."
HOMEPAGE="https://github.com/zear/libShake"
LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default
	sed -i 's/\/lib/\/$(LIBDIR)/g' "${S}/Makefile"
}

src_compile() {
	emake BACKEND="LINUX" all
}

src_install() {
	dodir /usr/$(get_libdir)
	dodir /usr/include
	emake DESTDIR="${D}" PREFIX="/usr" LIBDIR="$(get_libdir)" BACKEND="LINUX" install
}
