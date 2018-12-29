include(ExternalProject)

set(CONFIGURE_COMMAND
  ./bootstrap.sh --with-libraries=system,thread,date_time,filesystem --prefix=${3RD_PARTY_INSTALL_PREFIX})

set(BUILD_COMMAND
  ./b2)

ExternalProject_Add(
  Boost
  URL https://dl.bintray.com/boostorg/release/1.66.0/source/boost_1_66_0.tar.gz
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