include(ExternalProject)

set(BOOST_AGL_PROJECT_CONFIG_JAM
  "using gcc : agl : x86_64-agl-linux-gcc  -march=corei7 -mtune=corei7 -mfpmath=sse -msse4.2 --sysroot=/opt/agl-sdk/6.0.2-corei7-64/sysroots/corei7-64-agl-linux : ")

set(CONFIGURE_COMMAND
  CC=\"\" ./bootstrap.sh --with-libraries=system,thread,date_time,filesystem,atomic --prefix=${3RD_PARTY_INSTALL_PREFIX} COMMAND echo ${BOOST_AGL_PROJECT_CONFIG_JAM} $<SEMICOLON> >> ./project-config.jam)

set(BUILD_COMMAND
  ./b2 toolset=gcc-agl cxxflags=${CMAKE_CXX_FLAGS})

ExternalProject_Add(
  Boost
  URL http://dl.bintray.com/boostorg/release/1.66.0/source/boost_1_66_0.tar.gz
  DOWNLOAD_DIR ${BOOST_SOURCE_DIRECTORY}
  SOURCE_DIR ${BOOST_SOURCE_DIRECTORY}
  CONFIGURE_COMMAND ${CONFIGURE_COMMAND}
  BUILD_COMMAND ${BUILD_COMMAND}
  BUILD_IN_SOURCE true
  INSTALL_COMMAND ""
)

set(INSTALL_COMMAND
  "./b2 install > boost_install.log")

if (${3RD_PARTY_INSTALL_PREFIX} MATCHES "/usr/local")
  set(INSTALL_COMMAND "sudo ${INSTALL_COMMAND}")
endif()

install(
  CODE "execute_process(
    WORKING_DIRECTORY ${BOOST_SOURCE_DIRECTORY}
    COMMAND /bin/bash -c \"${INSTALL_COMMAND}\"
  )"
)
