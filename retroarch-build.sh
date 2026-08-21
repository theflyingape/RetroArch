#!/bin/sh
#
echo "Updating existing repository ... "
cd RetroArch
git pull

make clean
./configure --host=aarch64-linux-gnu --prefix=/retroarch \
	--disable-floathard --disable-neon --disable-rewind \
	--disable-caca --disable-cheats --disable-langextra \
	--disable-dispmanx --disable-opengl1 --disable-sdl --disable-sdl2 --disable-sdl3 \
	--disable-libusb --disable-parport --disable-roar --disable-winrawinput \
	--disable-d3d9 --disable-dinput --disable-dsound --disable-rsound \
	--disable-jack --disable-mpv --disable-oss --disable-tinyalsa \
	--disable-vg --disable-x11 --disable-xshm --disable-xvideo \
	--disable-v4l2 --disable-videoprocessor \
	--enable-cheevos --enable-command --enable-lua --enable-networking \
	--enable-materialui --enable-ozone --enable-rgui --enable-xmb \
	--enable-kms --enable-opengles --enable-qt --enable-sixel --enable-wayland \
	--enable-opengl --enable-opengles3 --enable-opengles3_1 --enable-opengles3_2 \
	--enable-opengl_core --enable-vulkan --enable-vulkan_display \
	--enable-alsa --enable-bluetooth --enable-ffmpeg --enable-networkgamepad \
	--enable-crtswitchres --enable-pipewire --enable-pulse \
	--enable-dbus --enable-hid --enable-libshake --enable-rpiled --enable-udev \
	--enable-ssl --enable-systemd --enable-wifi \
	--enable-threads --enable-thread_storage --enable-zlib 

CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ STRIP=aarch64-linux-gnu-strip make -j$(nproc)

cd -
