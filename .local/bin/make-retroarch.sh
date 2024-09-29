#!/bin/bash
#
# My compile script for RetroArch targeted for Debian Bookworm arm64,
# but running off a Pi 5 launched from Plasma (vk_wayland context) desktop 
#
cd ~
[ -d build ] || mkdir build

V="$1"

if [ "$V" = "new" ]; then
	# toolchain add-ons
	sudo apt install autoconf automake build-essential bison check cmake code dnsutils doxygen \
		flex git graphviz imagemagick libtool mesa-utils meson micro nasm ninja-build \
		pkg-config python3-dev python3-mako python3-pip texinfo valgrind vim wget yasm
	# toolchain libraries
	sudo apt install libasound2-dev libass-dev libassimp-dev libavcodec-dev libavdevice-dev \
		libavfilter-dev libavformat-dev libavresample-dev libavutil-dev libclc-dev libdrm* \
		libelf-dev libevdev-dev libflac-dev libfreetype6-dev libgbm-dev libgbm1 libgmp-dev \
		libgnutls28-dev libhidapi* libmbedtls*-dev libmp3lame-dev libmpv* libopenal-dev \
		libopencore-amrnb-dev libopencore-amrwb-dev libopus-dev librtmp-dev libsixel-dev \
		libsnappy-dev libsoxr-dev libsqlite3-dev libssh-dev libssl-dev libswresample-dev \
		libswscale-dev libsystemd-dev libudev-dev libunwind-dev libusb-1.0-0-dev libv4l-dev \
		libva-dev libvdpau-dev libvkd3d-dev libvo-amrwbenc-dev libvorbis-dev libwebp-dev \
		libx264-dev libx265-dev libxcb-shape0-dev libxcb-shm0-dev libxcb-xfixes0-dev \
		libxcb1-dev libxml2-dev libzstd-dev lzma-dev qtbase5-dev vc-dev yasm zlib1g-dev
	# SDL
	sudo apt install libsdl-image1.2-dev libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev \
		libsdl2-net-dev libsdl2-ttf-dev spirv-tools
	# X11
	sudo apt install libffi-dev libpciaccess-dev libpthread-stubs0-dev libx11-dev libx11-xcb-dev \
		libxcb*-dev libxcursor-dev libxdamage-dev libxext-dev libxfixes-dev libxkbcommon-dev \
		libxinerama-dev libxrandr-dev libxshmfence-dev libxxf86vm-dev x11proto-dri2-dev \
		x11proto-present-dev x11proto-randr-dev x11proto-xext-dev xutils-dev
	# OpenGL
	sudo apt install glslang-dev glslang-tools libegl-dev libegl-mesa0 libegl1 libegl1-mesa \
		libegl1-mesa-dev libgles2 libgles2-mesa libgles2-mesa-dev
	# Vulkan
	sudo apt install libvulkan-dev libvulkan1 mesa-common-dev mesa-vulkan-drivers vulkan-tools \
		vulkan-validationlayers-dev
	# Wayland
	sudo apt install libwayland-dev libwayland-egl-backend-dev qtbase5-dev wayland-protocols \
		wayland-utils
	# needed for Daphne 32-bit build
	sudo apt install libglew2.2:armhf libsdl1.2debian:armhf libvorbisfile3:armhf
	# needed toys
	sudo apt install 7kaa* angband barrage basic256 bsdgames btanks dstat empire extremetuxracer \
		fbi fonts-noto-color-emoji fs-uae gl-117* gnome-screenshot gnubg gpm iagno linuxlogo \
		mame moria mpc mpd mplayer-gui mpv neofetch nestopia neverball neverputt pysol* socat \
		steam-devices stella timidity vice vlc widelands wordwarvi*
	# more toys
	sudo apt install btop cc65 cc65-doc clinfo flatpak gamemode \
		glmark2-drm glmark-es2-drm glmark2-wayland glmark2-es2-wayland \
		plasma-gamemode plasma-discover-backend-flatpak rclone

	sudo apt update && sudo apt upgrade
	sudo rpi-eeprom-update -a
	sudo rpi-update

	vulkaninfo | grep Info || exit

	echo "pass 'git' or release version parameter as numeric major.minor.release to build/install"
	exit
fi

cd build

echo -n "Rebuild RetroArch? "
read yn

if [ "$yn" = "y" ]; then
	[ -d RetroArch ] || git clone https://github.com/libretro/RetroArch
	cd RetroArch
	if git pull ; then
	cp -v ~/Documents/led_sys_linux.c led/drivers/

	make clean
	CFLAGS='-O2 -march=armv8-a -mcpu=cortex-a72 -mtune=cortex-a72' \
	CXXFLAGS="${CFLAGS}" \
	./configure --prefix="${HOME}/.local" \
		--disable-floathard --disable-neon --disable-rewind \
		--disable-caca --disable-cheats --disable-langextra \
		--disable-libusb --disable-parport --disable-roar --disable-winrawinput \
		--disable-dispmanx --disable-opengl1 --disable-sdl \
		--disable-jack --disable-mpv --disable-oss --disable-tinyalsa \
		--disable-vg --disable-x11 --disable-xshm --disable-xvideo \
		--disable-ffmpeg --disable-v4l2 --disable-videoprocessor \
		--enable-cheevos --enable-command --enable-lua --enable-networking \
		--enable-materialui --enable-ozone --enable-rgui --enable-xmb \
		--enable-egl --enable-kms --enable-qt --enable-wayland \
		--enable-opengl --enable-opengl_core \
		--enable-opengles --enable-opengles3 --enable-opengles3_1 --enable-opengles3_2 \
		--enable-sdl2 --enable-sixel --enable-vulkan --enable-vulkan_display \
		--enable-alsa --enable-bluetooth --enable-crtswitchres --enable-pulse \
		--enable-dbus --enable-hid --enable-libshake --enable-rpiled --enable-udev \
		--enable-networkgamepad --enable-ssl --enable-systemd --enable-wifi \
		--enable-thread_storage --enable-threads --enable-zlib \
	|| exit

	time make -j4 && make install
	fi
	cd -
fi


ls -lh /retroarch/cores/bsnes-jg_libretro.so
echo -n "Rebuild SNES (bsnes-jg) core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d bsnes-jg ] || git clone https://github.com/libretro/bsnes-jg
	cd bsnes-jg
	git pull

	cd libretro
	make clean
	time make -j4
	cp -v bsnes-jg_libretro.so /retroarch/cores/
	cd - && cd ..
fi


ls -lh /retroarch/cores/gpsp_libretro.so
echo -n "Rebuild Game Boy Advance (gpSP) core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d gpsp ] || git clone https://github.com/libretro/gpsp
	cd gpsp
	git pull

	make clean
	time make -j4
	cp -v gpsp_libretro.so /retroarch/cores/
	cd -
fi


ls -lh /retroarch/cores/dolphin_libretro.so
echo -n "Rebuild Dolphin core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d dolphin ] || git clone https://github.com/libretro/dolphin
	cd dolphin
	git pull

	[ -d build ] || mkdir build
	cd build
	cmake ..
	make clean
	time make -j4 && cp -v dolphin_libretro.so /retroarch/cores/
	cd - && cd ..
fi


ls -lh /retroarch/cores/dosbox_pure_libretro.so
echo -n "Rebuild DOSBox Pure core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d dosbox-pure ] || git clone https://github.com/schellingb/dosbox-pure
	cd dosbox-pure
	git pull

	make clean
	time make -j4
	cp -v dosbox_pure_libretro.so /retroarch/cores/
	cd -
fi


ls -lh /retroarch/cores/fbneo_libretro.so
echo -n "Rebuild FinalBurn Neo (Light) core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d FBNeo ] || git clone https://github.com/libretro/FBNeo
	cd FBNeo
	git pull

	make -j4 -C src/burner/libretro LIGHT=1 generate-files-clean
	make -j4 -C src/burner/libretro LIGHT=1 generate-files
	make -j4 -C src/burner/libretro LIGHT=1
	cp -v src/burner/libretro/fbneo_libretro.so /retroarch/cores/
	cd -
fi


ls -lh /retroarch/cores/flycast_libretro.so
echo -n "Rebuild Flycast (Dreamcast) core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d flycast ] || git clone --recursive https://github.com/flyinghead/flycast.git

	cd flycast
	git pull

	[ -d build ] && rm -rf build
	mkdir build && cd build
	cmake -DLIBRETRO=ON -DUSE_OPENGL=OFF ..
	time make -j4

	cp -v flycast_libretro.so /retroarch/cores/
	cd ..
	cd ..
fi


ls -lh /retroarch/cores/genesis_plus_gx_libretro.so
echo -n "Rebuild Genesis Plus GX core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d Genesis-Plus-GX ] || git clone https://github.com/libretro/Genesis-Plus-GX
	cd Genesis-Plus-GX
	git pull

	time make -j4 -f Makefile.libretro
	cp -v genesis_plus_gx_libretro.so /retroarch/cores/
	cd -
fi


ls -lh /retroarch/cores/mame2003_plus_libretro.so
echo -n "Rebuild MAME 2003-plus core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d mame2003-plus-libretro ] || git clone https://github.com/libretro/mame2003-plus-libretro
	cd mame2003-plus-libretro
	git pull

	time make -j4
	cp -v mame2003_plus_libretro.so /retroarch/cores/
	cd -
fi

ls -lh /retroarch/cores/mame_libretro.so
echo -n "Rebuild MAME core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d mame ] || git clone https://github.com/libretro/mame
	cd mame
	git pull

	make clean
	time make -j4 -f Makefile.libretro && cp -v mame_libretro.so /retroarch/cores/
	cd -
fi


ls -lh /retroarch/cores/mesen_libretro.so
echo -n "Rebuild Mesen (NES) core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d Mesen ] || git clone https://github.com/libretro/Mesen
	cd Mesen
	git pull

	cd Libretro
	time make -j4
	cp -v mesen_libretro.so /retroarch/cores/
	cd ..
	cd ..
fi


ls -lh /retroarch/cores/mupen64plus_next_libretro.so
echo -n "Rebuild Mupen64Plus-Next core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d mupen64plus-libretro-nx ] || git clone https://github.com/libretro/mupen64plus-libretro-nx
	cd mupen64plus-libretro-nx
	git pull

	make clean
	time make -j4 FORCE_GLES3=1
	cp -v mupen64plus_next_libretro.so /retroarch/cores/
	cd -
fi


ls -lh /retroarch/cores/mednafen_pce_libretro.so
echo -n "Rebuild NEC PC Engine TG16-SuperGrafX (beetle fork) core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d beetle-pce-libretro ] || git clone https://github.com/libretro/beetle-pce-libretro
	cd beetle-pce-libretro
	git pull

	make clean
	time make -j4 -f Makefile
	cp -v mednafen_pce_libretro.so /retroarch/cores/
	cd -
fi


ls -lh /retroarch/cores/neocd_libretro.so
echo -n "Rebuild Neo Geo CD (SNK) core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d neocd_libretro ] || git clone https://github.com/libretro/neocd_libretro
	cd neocd_libretro
	git pull

	make clean
	time make -j4 -f Makefile
	cp -v neocd_libretro.so /retroarch/cores/
	cd -
fi


ls -lh /retroarch/cores/opera_libretro.so
echo -n "Rebuild Opera (3DO) core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d opera-libretro ] || git clone https://github.com/libretro/opera-libretro
	cd opera-libretro
	git pull

	make clean
	time make -j4
	cp -v opera_libretro.so /retroarch/cores/
	cd -
fi


ls -lh /retroarch/cores/pcsx_rearmed_libretro.so
echo -n "Rebuild PCSX Rearmed (PlayStation) core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d pcsx_rearmed ] || git clone https://github.com/libretro/pcsx_rearmed
	cd pcsx_rearmed
	git pull

	make clean
	time make -j4 -f Makefile.libretro
	cp -v pcsx_rearmed_libretro.so /retroarch/cores/
	cd -
fi


ls -lh /retroarch/cores/picodrive_libretro.so
echo -n "Rebuild PicoDrive core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d picodrive ] || git clone https://github.com/libretro/picodrive
	cd picodrive
	git pull

	./configure
	time make -j4 -f Makefile.libretro
	cp -v picodrive_libretro.so /retroarch/cores/
	cd -
fi


ls -lh /retroarch/cores/ppsspp_libretro.so
echo -n "Rebuild PPSSPP core only out of libretro-super? "
read yn

if [ "$yn" = "y" ]; then
	[ -d libretro-super ] || git clone https://github.com/libretro/libretro-super.git
	cd libretro-super/
	git pull
	SHALLOW_CLONE=1 ./libretro-fetch.sh retroarch

	cd libretro-ppsspp
	time ./b.sh --rpi64 --libretro
	cp -v build/lib/ppsspp_libretro.so /retroarch/cores/
	cd ..
	cd ..
fi


ls -lh /retroarch/cores/puae_libretro.so
echo -n "Rebuild PUAE (Amiga) core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d libretro-uae ] || git clone https://github.com/libretro/libretro-uae
	cd libretro-uae
	git pull

	time make -j4
	cp -v puae_libretro.so /retroarch/cores/
	cd -
fi


ls -lh /retroarch/cores/same_cdi_libretro.so
echo -n "Rebuild SAME CDi core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d same_cdi ] || git clone https://github.com/libretro/same_cdi
	cd same_cdi
	git pull

	time make -j4 -f Makefile.libretro
	cp -v same_cdi_libretro.so /retroarch/cores/
	cd -
fi


ls -lh /retroarch/cores/stella2014_libretro.so
echo -n "Rebuild Stella 2014 (Atari 2600) core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d stella2014-libretro ] || git clone https://github.com/libretro/stella2014-libretro
	cd stella2014-libretro
	git pull

	time make -j4
	cp -v stella2014_libretro.so /retroarch/cores/
	cd -
fi


ls -lh /retroarch/cores/vice_*_libretro.so
echo -n "Rebuild VICE (Commodore 8-bit) core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d vice-libretro ] || git clone https://github.com/libretro/vice-libretro
	cd vice-libretro
	git pull

	for type in x128 x64 x64sc xpet xplus4 xvic; do
		make clean
		make -j4 EMUTYPE=${type}
		cp -v vice_${type}_libretro.so /retroarch/cores/
	done
	cd -
fi


ls -lh /retroarch/cores/px68k_libretro.so
echo -n "Rebuild X68000 (Sharp) core? "
read yn

if [ "$yn" = "y" ]; then
	[ -d px68k-libretro ] || git clone https://github.com/libretro/px68k-libretro
	cd px68k-libretro
	git pull

	make clean
	time make -j4 -f Makefile
	cp -v px68k_libretro.so /retroarch/cores/
	cd -
fi


echo -n "Rebuild cores from Super project (Pi5: 6+ or Pi4: 20+ hours)? "
read yn

if [ "$yn" = "y" ]; then
	[ -d libretro-super ] || git clone https://github.com/libretro/libretro-super.git
	cd libretro-super
	git pull

	SHALLOW_CLONE=1 ./libretro-fetch.sh retroarch
	time make -j4
	cd -
fi
