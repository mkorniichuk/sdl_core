#!/bin/bash

SDLDIR=/home/developer/sdl
BUILDDIR=/home/developer/sdl/build
SDKENV=/opt/agl-sdk/6.0.2-corei7-64/environment-setup-corei7-64-agl-linux

function LOG() {
    echo "#########################################################################"
    echo "#         $@"
    echo "#########################################################################"
}

function RUN() {
    echo "+ $@"; eval $@
}

export -f RUN
export -f LOG

#######################################
LOG "Check SDK"
#######################################

if [[ ! -f $SDKENV ]]; then
    echo "$SDKENV file not found. Please, make sure SDK for AGL installed correctly."
    exit 1
fi

#######################################
LOG "Setting environmet"
#######################################

export THIRD_PARTY_INSTALL_PREFIX=/home/developer/3rd_party
export THIRD_PARTY_INSTALL_PREFIX_ARCH=/home/developer/3rd_party/x86_64
source /opt/agl-sdk/6.0.2-corei7-64/environment-setup-corei7-64-agl-linux

#######################################
LOG "CMake"
#######################################

if [[ -d $BUILDDIR ]]; then
    echo "$BUILDDIR already exists. Removing the directory."
    rm -rf $BUILDDIR
fi

mkdir $BUILDDIR && cd $BUILDDIR
echo "Current working directory: $(pwd)"
echo "Running cmake..."

RUN "cmake $SDLDIR -DCMAKE_TOOLCHAIN_FILE=$SDLDIR/agl_linux_x86_64.cmake"

if [[ $? -ne 0 ]]; then
    LOG "CMake failed. Exiting container..."
    exit 1
fi

#######################################
LOG "Build"
#######################################

export LD_LIBRARY_PATH=$THIRD_PARTY_INSTALL_PREFIX/lib:$THIRD_PARTY_INSTALL_PREFIX_ARCH/lib:.
RUN "make install"
if [[ $? -ne 0 ]]; then
    LOG "Build failed. Exiting container..."
    exit 1
fi

#######################################
LOG "Collect runtime libs"
#######################################

cd $BUILDDIR/bin
RUN "ldd smartDeviceLinkCore | grep \"$THIRD_PARTY_INSTALL_PREFIX\|$THIRD_PARTY_INSTALL_PREFIX_ARCH\|$BUILDDIR\" | grep -v $BUILDDIR/bin | awk '{print \$3}' | xargs -L1 -I LIB bash -c 'RUN cp LIB ./'"

#######################################
LOG "Built successfully!"
#######################################
