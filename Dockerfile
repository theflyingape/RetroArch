FROM debian:trixie AS builder

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# enable arm64 multiarch and install host development tools + cross-compiler
RUN dpkg --add-architecture arm64 \
	&& apt-get update && apt-get install -y --no-install-recommends \
	    build-essential \
    	crossbuild-essential-arm64 \
    	git \
    	pkg-config

# install ARM64 libraries needed for RetroArch
RUN apt-get install -y \
    zlib1g-dev:arm64 \
    libsdl2-dev:arm64 \
    libavcodec-dev:arm64 \
    libavformat-dev:arm64 \
    libavutil-dev:arm64 \
    libswscale-dev:arm64 \
    libudev-dev:arm64 \
    libusb-1.0-0-dev:arm64 \
    libfreetype6-dev:arm64 \
    libasound2-dev:arm64 \
    libpulse-dev:arm64
# no X11 wanted
#	libx11-dev:arm64 \
#	libxext-dev:arm64 \
#	libxinerama-dev:arm64 \
#	libxrandr-dev:arm64

# additional needs for features
RUN apt-get install -y \
		libasound2-dev:arm64 \
		libass-dev:arm64 \
		libavcodec-dev:arm64 \
		libavfilter-dev:arm64 \
		libavformat-dev:arm64 \
		libavutil-dev:arm64 \
		libdrm-dev:arm64 \
		libflac-dev:arm64 \
		libhidapi-dev:arm64 \
		libpipewire-0.3-dev:arm64 \
		libsixel-dev:arm64 \
		libsystemd-dev:arm64 \
		libx264-dev:arm64 \
		libx265-dev:arm64

# add OpenGL support
RUN apt-get install -y \
	libegl-dev:arm64

# add Vulkan support
RUN apt-get install -y \
	libvulkan-dev:arm64 \
	mesa-common-dev:arm64 \
	mesa-vulkan-drivers:arm64

# add Wayland support
RUN apt-get install -y \
	libwayland-dev:arm64 \
	libwayland-egl-backend-dev:arm64

RUN rm -rf /var/lib/apt/lists/*

# build RetroArch
WORKDIR /build

# create a shell script to handle persistent caching and compilation
RUN echo '#!/bin/sh\n\
if [ ! -d "retroarch/.git" ]; then\n\
    echo "First run: Cloning RetroArch repository..."\n\
    git clone --depth 1 https://github.com/libretro/RetroArch\n\
else\n\
    echo "Cache hit: Updating existing repository..."\n\
    cd RetroArch && git fetch --depth 1 && git reset --hard origin/master && cd ..\n\
fi\n\
\n\
cd RetroArch\n\
./configure --host=aarch64-linux-gnu --prefix=/retroarch \n\
	--disable-floathard --disable-neon --disable-rewind \n\
	--disable-caca --disable-cheats --disable-langextra \n\
	--disable-dispmanx --disable-opengl1 --disable-sdl \n\
	--disable-libusb --disable-parport --disable-roar --disable-winrawinput \n\
	--disable-d3d9 --disable-dinput --disable-dsound --disable-rsound \n\
	--disable-jack --disable-mpv --disable-oss --disable-tinyalsa \n\
	--disable-vg --disable-x11 --disable-xshm --disable-xvideo \n\
	--disable-v4l2 --disable-videoprocessor \n\
	--enable-cheevos --enable-command --enable-lua --enable-networking \n\
	--enable-materialui --enable-ozone --enable-rgui --enable-xmb \n\
	--enable-kms --enable-opengles --enable-qt --enable-sixel --enable-wayland \n\
	--enable-opengl --enable-opengles3 --enable-opengles3_1 --enable-opengles3_2 \n\
	--enable-opengl_core --enable-sdl3 --enable-vulkan --enable-vulkan_display \n\
	--enable-alsa --enable-bluetooth --enable-ffmpeg --enable-networkgamepad \n\
	--enable-crtswitchres --enable-pipewire --enable-pulse \n\
	--enable-dbus --enable-hid --enable-libshake --enable-rpiled --enable-udev \n\
	--enable-ssl --enable-systemd --enable-wifi \n\
	--enable-threads --enable-thread_storage --enable-zlib \n\
make clean\n\
CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ STRIP=aarch64-linux-gnu-strip make -j$(nproc)\n\
make DESTDIR=/build/output install' > /build/build_retroarch.sh \
    && chmod +x /build/build_retroarch.sh

# Run the script when the container executes
CMD ["/build/build_retroarch.sh"]
