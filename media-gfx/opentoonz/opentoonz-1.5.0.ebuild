# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/opentoonz/opentoonz/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/opentoonz/opentoonz.git"
fi

DESCRIPTION="An open-source full-featured 2D animation creation software"
HOMEPAGE="https://opentoonz.github.io/"
LICENSE="BSD libtiff"
SLOT="0"

DEPEND="
	app-arch/lz4:=
	>=dev-libs/boost-1.55.0:=
	dev-libs/lzo:2
	>=dev-qt/qtcore-5.9:5
	>=dev-qt/qtgui-5.9:5
	>=dev-qt/qtmultimedia-5.9:5[widgets]
	>=dev-qt/qtnetwork-5.9:5
	>=dev-qt/qtopengl-5.9:5
	>=dev-qt/qtprintsupport-5.9:5
	>=dev-qt/qtscript-5.9:5
	>=dev-qt/qtserialport-5.9:5
	>=dev-qt/qtsvg-5.9:5
	>=dev-qt/qtwidgets-5.9:5
	>=dev-qt/qtxml-5.9:5
	media-libs/freeglut
	media-libs/freetype:2
	media-libs/glew:=
	media-libs/libjpeg-turbo
	>=media-libs/libmypaint-1.3.0:=
	media-libs/libpng:=
	media-libs/opencv
	>=sci-libs/superlu-4.1:=
	sys-libs/zlib
	virtual/cblas
	virtual/libusb:1
	virtual/opengl
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-qt/linguist-tools:5
	virtual/pkgconfig
"

CMAKE_USE_DIR="${S}/toonz/sources"

src_configure() {
	local mycmakeargs=(
		-DTIFF_LIBRARY="${S}/thirdparty/tiff-4.0.3/libtiff/.libs/libtiff.a"
		-DSUPERLU_INCLUDE_DIR="${EPREFIX}/usr/include/superlu"
		-DLZO_INCLUDE_DIR="${EPREFIX}/usr/include/lzo"
		-DCMAKE_SKIP_RPATH=ON
	)

	# The upstream uses their own modified libtiff
	# See: https://github.com/opentoonz/opentoonz/blob/master/doc/how_to_build_linux.md#building-libtiff
	cd "thirdparty/tiff-4.0.3" || die
	econf \
		--with-pic \
		--disable-jbig \
		--enable-static \
		--disable-shared

	cmake_src_configure
}

src_compile() {
	cd "${S}/thirdparty/tiff-4.0.3" || die
	emake
	cmake_src_compile
}
