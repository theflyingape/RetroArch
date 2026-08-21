FROM debian:trixie AS builder

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# enable arm64 multiarch and install host development tools + cross-compiler
RUN dpkg --add-architecture arm64 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
	    build-essential \
    	crossbuild-essential-arm64 \
    	git \
    	pkg-config

# install ARM64 libraries needed for RetroArch
RUN apt-get install -y \
    zlib1g-dev:arm64 \
    libavcodec-dev:arm64 \
    libavformat-dev:arm64 \
    libavutil-dev:arm64 \
    libswscale-dev:arm64 \
    libudev-dev:arm64 \
    libusb-1.0-0-dev:arm64 \
    libfreetype6-dev:arm64 \
    libasound2-dev:arm64 \
    libpulse-dev:arm64

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
	libx265-dev:arm64 \
	qt6-base-dev:arm64

# add optional SDL3 support
RUN apt-get install -y \
	libsdl3-dev:arm64 \
	libsdl3-image-dev:arm64 \
	libsdl3-ttf-dev:arm64

# add required OpenGL support
RUN apt-get install -y \
	libegl-dev:arm64

# add required Vulkan support
RUN apt-get install -y \
	libvulkan-dev:arm64 \
	mesa-common-dev:arm64 \
	mesa-vulkan-drivers:arm64

# add required Wayland support
RUN apt-get install -y \
	libwayland-dev:arm64 \
	libwayland-egl-backend-dev:arm64

RUN rm -rf /var/lib/apt/lists/*

# clone and build RetroArch
WORKDIR /build
RUN [ -d "RetroArch/.git" ] || git clone https://github.com/libretro/RetroArch
COPY retroarch-build.sh .

# force a pull of the latest RetroArch source code when PULL is not zero
ARG PULL=0
RUN apt-get update && chmod +x retroarch-build.sh && ./retroarch-build.sh
WORKDIR /build/RetroArch
RUN make install DESTDIR=/retroarch
