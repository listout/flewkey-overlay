# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/matham/ffpyplayer.git"
else
	SRC_URI="https://github.com/matham/ffpyplayer/archive/v${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Python bindings for the FFmpeg media player"
HOMEPAGE="https://matham.github.io/ffpyplayer/"
LICENSE="LGPL-3"
SLOT="0"

DEPEND="
	media-video/ffmpeg[postproc]
	media-libs/libsdl2
	media-libs/sdl2-mixer
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

distutils_enable_tests setup.py
