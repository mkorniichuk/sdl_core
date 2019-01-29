#!/bin/bash

SDLDIR=/home/developer/sdl
BUILDDIR=/home/developer/sdl/build
SDK=/opt/qnx700

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

if [[ ! -d $SDK ]]; then
    echo "$SDK file not found. Please, make sure SDK for AGL installed correctly."
    exit 1
fi

#######################################
LOG "Setting environmet"
#######################################

export THIRD_PARTY_INSTALL_PREFIX=/home/developer/3rd_party
export THIRD_PARTY_INSTALL_PREFIX_ARCH=/home/developer/3rd_party/x86_64
export QNX_HOST=$SDK/host/linux/x86_64
export QNX_TARGET=$SDK/target/qnx7

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

RUN "cmake $SDLDIR -DCMAKE_TOOLCHAIN_FILE=$SDLDIR/toolchains/Toolchain-QNX7-ACC-x86.cmake"

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
LOG "Collect runtime SDK libs"
#######################################

LIBS=(libqdb.so.1 \
    libaoi.so.1 \
    libicudata.so.58 \
    libicui18n.so.58 \
    libicuuc.so.58 \
    libsqlite3.so.1 \
    libstrm.so.1)

for LIB in ${LIBS[@]}; do
    RUN "cp $QNX_TARGET/x86_64/usr/lib/$LIB ./"
done

#######################################
LOG "Built successfully!"
#######################################
