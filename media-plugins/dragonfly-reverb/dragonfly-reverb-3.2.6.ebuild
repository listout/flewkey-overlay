# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/michaelwillis/dragonfly-reverb.git"
	EGIT_SUBMODULES=( dpf dpf/dgl/src/pugl-upstream )
else
	DPF_REF="39cd4986bfa489fa43ef84cf05b4871d14710135"
	PUGL_REF="0fdc19059de5214973ae6ec0d775470f94ceb1c9"
	SRC_URI="
		https://github.com/michaelwillis/dragonfly-reverb/archive/${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/DISTRHO/DPF/archive/${DPF_REF}.tar.gz -> dpf-${DPF_REF}.tar.gz
		https://github.com/DISTRHO/pugl/archive/${PUGL_REF}.tar.gz -> pugl-${PUGL_REF}.tar.gz
	"
	KEYWORDS="~amd64"
fi

DESCRIPTION="A set of free reverb effects"
HOMEPAGE="https://michaelwillis.github.io/dragonfly-reverb/"
LICENSE="GPL-3"
SLOT="0"
IUSE="system-freeverb3"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	system-freeverb3? ( media-libs/freeverb3 )
	system-freeverb3? ( media-libs/libsamplerate )
	virtual/jack
	x11-libs/libX11
"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
	else
		default
		rm -rf "${S}/dpf" || die
		ln -s "${WORKDIR}/DPF-${DPF_REF}" "${S}/dpf" || die
		rm -rf "${S}/dpf/dgl/src/pugl-upstream" || die
		ln -s "${WORKDIR}/pugl-${PUGL_REF}" "${S}/dpf/dgl/src/pugl-upstream" || die
	fi
}

src_compile() {
	export SKIP_STRIPPING=true
	if use system-freeverb3; then
		export SYSTEM_FREEVERB3=true
	fi
	default_src_compile
}

src_install() {
	dobin bin/DragonflyEarlyReflections
	dobin bin/DragonflyPlateReverb
	dobin bin/DragonflyHallReverb
	dobin bin/DragonflyRoomReverb
	dodir /usr/$(get_libdir)/vst
	cp "${S}/bin/DragonflyEarlyReflections-vst.so" "${D}/usr/$(get_libdir)/vst"
	cp "${S}/bin/DragonflyPlateReverb-vst.so" "${D}/usr/$(get_libdir)/vst"
	cp "${S}/bin/DragonflyHallReverb-vst.so" "${D}/usr/$(get_libdir)/vst"
	cp "${S}/bin/DragonflyRoomReverb-vst.so" "${D}/usr/$(get_libdir)/vst"
	dodir /usr/$(get_libdir)/vst3
	cp -r "${S}/bin/DragonflyEarlyReflections.vst3" "${D}/usr/$(get_libdir)/vst3"
	cp -r "${S}/bin/DragonflyPlateReverb.vst3" "${D}/usr/$(get_libdir)/vst3"
	cp -r "${S}/bin/DragonflyHallReverb.vst3" "${D}/usr/$(get_libdir)/vst3"
	cp -r "${S}/bin/DragonflyRoomReverb.vst3" "${D}/usr/$(get_libdir)/vst3"
	dodir /usr/$(get_libdir)/lv2
	cp -r "${S}/bin/DragonflyEarlyReflections.lv2" "${D}/usr/$(get_libdir)/lv2"
	cp -r "${S}/bin/DragonflyPlateReverb.lv2" "${D}/usr/$(get_libdir)/lv2"
	cp -r "${S}/bin/DragonflyHallReverb.lv2" "${D}/usr/$(get_libdir)/lv2"
	cp -r "${S}/bin/DragonflyRoomReverb.lv2" "${D}/usr/$(get_libdir)/lv2"
}
