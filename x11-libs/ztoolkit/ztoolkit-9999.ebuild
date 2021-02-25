# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://git.zrythm.org/cgit/ztoolkit/snapshot/${P}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://git.zrythm.org/git/ztoolkit"
fi

DESCRIPTION="GUI toolkit for LV2 plugins"
HOMEPAGE="https://git.zrythm.org/cgit/ztoolkit/"
LICENSE="GPL-3"
SLOT="0"
IUSE="rsvg"

DEPEND="
	rsvg? ( >=gnome-base/librsvg-2.14 )
	x11-libs/cairo
	x11-libs/libX11
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local emesonargs=(
		$(meson_use rsvg enable_rsvg)
	)
	meson_src_configure
}
