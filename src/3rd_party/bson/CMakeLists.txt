# Copyright (c) 2018, Ford Motor Company
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

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}")

find_package(BSON)

if ((BSON_FOUND OR NO_REBUILD_3RD_PARTY) AND
    NOT FORCE_3RD_PARTY)

  add_custom_target(libbson)
else()
  message(STATUS "Did not find bson. Building and installing bson required")

  set(BSON_LIB_SOURCE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bson_c_lib)
  set(BSON_LIBS_DIRECTORY ${BSON_LIB_SOURCE_DIRECTORY}/src/.libs CACHE INTERNAL "Installation path of bson libraries" FORCE)
  set(EMHASHMAP_LIBS_DIRECTORY ${BSON_LIB_SOURCE_DIRECTORY}/src/emhashmap/.libs CACHE INTERNAL "Installation path of emashmap libraries" FORCE)
  set(BSON_INCLUDE_DIRECTORY ${BSON_LIB_SOURCE_DIRECTORY}/src CACHE INTERNAL "Installation path of bson headers" FORCE)
  set(EMHASHMAP_INCLUDE_DIRECTORY ${BSON_LIB_SOURCE_DIRECTORY}/src/emhashmap CACHE INTERNAL "Installation path of emashmap headers" FORCE)

  include(${TARGET_PLATFORM})
endif()
