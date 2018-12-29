set(TARGET_PLATFORM AGL)

include(/opt/agl-sdk/6.0.2-corei7-64/sysroots/x86_64-aglsdk-linux/usr/share/cmake/OEToolchainConfig.cmake)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")