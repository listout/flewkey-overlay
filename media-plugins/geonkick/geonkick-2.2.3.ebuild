EAPI=7

inherit cmake-utils

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/iurie-sw/geonkick/archive/v${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/iurie-sw/geonkick.git"
fi

DESCRIPTION="A free software percussion synthesizer"
HOMEPAGE="https://github.com/iurie-sw/geonkick"
LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/rapidjson
	media-libs/libsndfile
	media-libs/lv2
	x11-libs/redkite
"
