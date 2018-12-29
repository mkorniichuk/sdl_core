include(ExternalProject)

set(CONFIGURE_FLAGS
  "--prefix=${3RD_PARTY_INSTALL_PREFIX}")

set(CONFIGURE_COMMAND
  touch aclocal.m4 configure.ac Makefile.am Makefile.in configure config.h.in && ./configure ${CONFIGURE_FLAGS})


ExternalProject_Add(
  libbson
  GIT_REPOSITORY "http://github.com/smartdevicelink/bson_c_lib.git"
  GIT_TAG "master"
  DOWNLOAD_DIR ${BSON_LIB_SOURCE_DIRECTORY}
  SOURCE_DIR ${BSON_LIB_SOURCE_DIRECTORY}
  CONFIGURE_COMMAND ${CONFIGURE_COMMAND}
  BUILD_IN_SOURCE true
  INSTALL_COMMAND ""
  UPDATE_COMMAND ""
)

set(INSTALL_COMMAND "make install")

if (${3RD_PARTY_INSTALL_PREFIX} MATCHES "/usr/local")
  set(INSTALL_COMMAND "sudo ${INSTALL_COMMAND}")
endif()

install(
  CODE "execute_process(
    WORKING_DIRECTORY ${BSON_LIB_SOURCE_DIRECTORY}
    COMMAND /bin/bash -c \"${INSTALL_COMMAND}\"
  )"
)
