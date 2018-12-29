# Copyright (c) 2014, Ford Motor Company
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer.
#
# Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following
# disclaimer in the documentation and/or other materials provided with the
# distribution.
#
# Neither the name of the Ford Motor Company nor the names of its contributors
# may be used to endorse or promote products derived from this software
# without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR})

set(APR_UTIL_FIND_VERSION 1.5.3)
set(APR_UTIL_USE_SYSTEM_PATH 0)
find_package(APRUtil)

if ((APU_FOUND OR NO_REBUILD_3RD_PARTY_LOGGER) AND
    NOT FORCE_3RD_PARTY_LOGGER)

    add_custom_target(apr-util)
else()
  if (APU_FOUND AND FORCE_3RD_PARTY_LOGGER)
    message(WARNING "Apr Util found but has to be reinstalled.")
  else()
    message(STATUS "Did not found Apr Util. Installing Apr Util")
  endif()
  set(APR_UTIL_SOURCE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/apr-util-1.5.3)
  set(APR_UTIL_BUILD_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/apr-util-build)

  set(APR_UTIL_LIBS_DIRECTORY ${APR_UTIL_BUILD_DIRECTORY}/.libs  CACHE INTERNAL "Path of APR Util libraries" FORCE)

  file(MAKE_DIRECTORY
    ${APR_UTIL_BUILD_DIRECTORY}
  )

  set(EXPAT_SOURCE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../expat-2.1.0)
  set(EXPAT_BUILD_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/../expat-2.1.0)

  set(APR_PREFIX_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/../apr/apr-build)

  include(${TARGET_PLATFORM})

  add_custom_target(apr-util ALL make
    DEPENDS ${APR_UTIL_BUILD_DIRECTORY}/Makefile
    WORKING_DIRECTORY ${APR_UTIL_BUILD_DIRECTORY}
  )

  install(
    DIRECTORY ${APR_UTIL_LIBS_DIRECTORY}/
    DESTINATION ${3RD_PARTY_INSTALL_PREFIX_ARCH}/lib
    USE_SOURCE_PERMISSIONS
    FILES_MATCHING PATTERN libaprutil-1.so*
  )
endif()