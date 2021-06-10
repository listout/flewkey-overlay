# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTERM_REF="65269a7a3ea4d3b39e1a58e0faa56d84286e0861" # 0.5b10
MY_P="pyterminal-${PYTERM_REF}"
S="${WORKDIR}/${MY_P}"

inherit distutils-r1

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://gitlab.com/mocchapi/pyterminal/-/archive/${PYTERM_REF}/archive.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/mocchapi/pyterminal.git"
fi

DESCRIPTION="Command line YouTube music streamer"
HOMEPAGE="https://gitlab.com/mocchapi/pyterminal"
LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="
	${DEPEND}
	dev-python/feedparser
	dev-python/pafy
	dev-python/python-vlc
	dev-python/pypresence
	dev-python/youtube-search-python
	net-misc/youtube-dl
"
BDEPEND=""
