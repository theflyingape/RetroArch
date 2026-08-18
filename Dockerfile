FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive

# enable arm64 multiarch and install host development tools + cross-compiler
RUN dpkg --add-architecture arm64 \
	&& apt-get update && apt-get install -y \
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

WORKDIR /workspace

# build RetroArch
RUN git clone https://github.com/libretro/RetroArch && \
    cd RetroArch \
    && ./configure --host=aarch64-linux-gnu- --prefix=/workspace/output \
    && make -j$(nproc) \
    && make install
