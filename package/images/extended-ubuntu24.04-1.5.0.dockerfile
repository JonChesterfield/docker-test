FROM docker.io/spectralcompute/scale:13.0.2-devel-ubuntu24.04-1.5.0

ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

RUN apt-get update

RUN <<EOF
    set -ETeuo pipefail

    # Install various packages we need for testing.
    PACKAGES=(
        # CI system.
        rsync

        # Packages for testing.
        libbenchmark-dev
        libgmock-dev
        libgtest-dev

        # Various projects.
        imagemagick
        python3

        # Alien.
        curl
        libgl-dev
        libglu1-mesa-dev
        libxcursor-dev
        libxi-dev
        libxinerama-dev
        xorg-dev
        zip

        # CUTLASS
        bc

        # Cycles
        git-lfs
        libavcodec-dev
        libavdevice-dev
        libavfilter-dev
        libavformat-dev
        libavutil-dev
        libboost-dev
        libembree-dev
        libgflags-dev
        libgoogle-glog-dev
        libmagickcore-dev
        libopenimageio-dev
        libopenjp2-7-dev
        libosd-dev
        libpng-dev
        libpostproc-dev
        libpugixml-dev
        libswresample-dev
        libswscale-dev
        libtiff-dev
        libwebp-dev
        time
        zlib1g-dev

        # GPUJPEG
        ffmpeg

        # xgboost
        python3-build
        python3-hatchling
        python3-wheel
        python3-pandas
        python3-scipy
        python3-sklearn

        # Faiss
        libopenblas-dev
        python3-numpy
        python3-installer
        swig

        # TCLB
        r-base
        r-base-dev
        libopenmpi-dev

        # FastEddy
        libnetcdf-dev

        # pytorch
        python3-setuptools
        python3-yaml

        # FastEddy
        jupyter-notebook
        python3-xarray

        # caffe
        libboost-filesystem-dev
        libboost-system-dev
        libboost-thread-dev
        libhdf5-serial-dev
        libleveldb-dev
        liblmdb-dev
        libopencv-dev
        libprotobuf-dev
        libsnappy-dev
        protobuf-compiler

        # hashinator
        meson

        # arrayfire
        libfftw3-dev
        libatlas-base-dev
    )
    apt-get install -y "${PACKAGES[@]}"
EOF
