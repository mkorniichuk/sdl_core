FROM ubuntu:16.04

RUN apt-get update && apt-get install -yq \
    sudo \
    git \
    wget \
    vim \
    gitk \
    meld \
    tree \
    mc \
    xz-utils \
    g++ \
    make \
    automake \
    xz-utils

# Cmake
#######################################################################
#
#       Currently the cmake 2.8 is enough for building SDL.
#       Uncomment following lines in order to use CMake 3.11.0
#
#######################################################################
# ARG CMAKE_PREFIX="/opt/cmake-3.11.0/bin"
# RUN wget --no-check-certificate https://cmake.org/files/v3.11/cmake-3.11.0.tar.gz && \
#     tar -xzvf cmake-3.11.0.tar.gz && \
#     cd cmake-3.11.0 && \
#     ./bootstrap --prefix=$CMAKE_PREFIX && \
#     make && \
#     make install && \
#     sed -i "s|export\ PATH=|export\ PATH=$CMAKE_PREFIX:|" /opt/agl-sdk/6.0.2-corei7-64/environment-setup-corei7-64-agl-linux

COPY entrypoint.sh /usr/bin/

COPY build.sh /usr/bin/build
RUN chmod +x /usr/bin/build

ENTRYPOINT ["/bin/bash", "-e", "/usr/bin/entrypoint.sh"]
