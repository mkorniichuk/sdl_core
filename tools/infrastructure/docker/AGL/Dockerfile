FROM ubuntu:16.04

RUN apt-get update && apt-get install -yq \
    sudo \
    git \
    wget \
    g++ \
    make \
    automake \
    xz-utils \
    python

WORKDIR /opt

# SDK Setup
RUN wget https://download.automotivelinux.org/AGL/release/flounder/6.0.2/qemux86-64/deploy/sdk/poky-agl-glibc-x86_64-agl-demo-platform-crosssdk-corei7-64-toolchain-6.0.2.sh \
    --no-check-certificate -t 3 -T 60 -O setupSDK.sh
RUN chmod +x /opt/setupSDK.sh && \
    /opt/setupSDK.sh -y
RUN echo "source /opt/agl-sdk/6.0.2-corei7-64/environment-setup-corei7-64-agl-linux" >> /etc/bash.bashrc

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
