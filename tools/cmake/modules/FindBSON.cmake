# Copyright (c) 2019, Ford Motor Company
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

if(BSON_FOUND)
  message(STATUS "Found Bson: ${BSON_INCLUDE_DIRECTORY}")
  message(STATUS "Found Emhashmap: ${EMHASHMAP_INCLUDE_DIRECTORY}")
  return()
endif()

if (NOT DEFINED BSON_USE_SYSTEM_PATH)
  set(BSON_USE_SYSTEM_PATH 1)
endif()

set(Bson_FOUND 1)

###########################
# Looking for BSON headers
###########################

find_path(BSON_OBJECT_INCLUDE
  NAMES
    bson_object.h
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX}
  PATH_SUFFIXES
    include
    include/bson
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (BSON_USE_SYSTEM_PATH)
  find_path(BSON_OBJECT_INCLUDE
    NAMES
      bson_object.h
    PATH_SUFFIXES
      include
      include/bson
  )
endif()
message(STATUS "Bson: bson_object.h => ${BSON_OBJECT_INCLUDE}")

find_path(BSON_UTIL_INCLUDE
  NAMES
    bson_util.h
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX}
  PATH_SUFFIXES
    include
    include/bson
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (BSON_USE_SYSTEM_PATH)
  find_path(BSON_UTIL_INCLUDE
    NAMES
      bson_util.h
    PATHS
      ${INCLUDE_PATH}
  )
endif()
message(STATUS "Bson: bson_util.h => ${BSON_UTIL_INCLUDE}")

find_path(BSON_ARRAY_INCLUDE
  NAMES
    bson_array.h
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX}
  PATH_SUFFIXES
    include
    include/bson
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (BSON_USE_SYSTEM_PATH)
  find_path(BSON_ARRAY_INCLUDE
    NAMES
      bson_array.h
    PATH_SUFFIXES
      include
      include/bson
  )
endif()
message(STATUS "Bson: bson_array.h => ${BSON_ARRAY_INCLUDE}")

find_library(BSON_LIB
  NAMES
    bson
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX}
  PATH_SUFFIXES
    lib
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (BSON_USE_SYSTEM_PATH)
  find_library(BSON_LIB
    NAMES
      bson
    PATH_SUFFIXES
      lib
  )
endif()
message(STATUS "Bson: ibbson.so => ${BSON_LIB}")

###########################
# Looking for emhashmap headers
###########################

find_path(EMHASHMAP_INCLUDE_DIRECTORY
  NAMES
    emhashmap.h
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX}
  PATH_SUFFIXES
    include
    include/emhashmap
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (BSON_USE_SYSTEM_PATH)
  find_path(EMHASHMAP_INCLUDE_DIRECTORY
    NAMES
      emhashmap.h
    PATH_SUFFIXES
      include
      include/emhashmap
  )
endif()
message(STATUS "Emhashmap: emhashmap.h => ${EMHASHMAP_INCLUDE_DIRECTORY}")

find_library(EMHASHMAP_LIB
  NAMES
    emhashmap
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX}
  PATH_SUFFIXES
    lib
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (BSON_USE_SYSTEM_PATH)
  find_library(EMHASHMAP_LIB
    NAMES
      emhashmap
    PATH_SUFFIXES
      lib
  )
endif()
message(STATUS "Emhashmap: libemhashmap.so => ${EMHASHMAP_LIB}")

if (BSON_OBJECT_INCLUDE AND
    BSON_UTIL_INCLUDE AND
    BSON_ARRAY_INCLUDE AND
    BSON_LIB AND
    EMHASHMAP_INCLUDE_DIRECTORY AND
    EMHASHMAP_LIB)
  if (NOT (${BSON_OBJECT_INCLUDE} STREQUAL ${BSON_UTIL_INCLUDE}) OR
      NOT (${BSON_OBJECT_INCLUDE} STREQUAL ${BSON_ARRAY_INCLUDE}))
    message(WARNING "Please, take a look at Bson include directories: they are not the same for different components.")
    set(Bson_FOUND 0)
  endif()

  get_filename_component(BSON_LIB_DIR ${BSON_LIB} DIRECTORY)
  get_filename_component(EMHASHMAP_LIB_DIR ${EMHASHMAP_LIB} DIRECTORY)
else()
  message(STATUS "Failed to find Bson components.")
  set(Bson_FOUND 0)
endif()

if (Bson_FOUND)
  set(BSON_FOUND 1 CACHE INTERNAL "Bson found" FORCE)
  set(BSON_INCLUDE_DIRECTORY ${BSON_OBJECT_INCLUDE} CACHE INTERNAL "Bson include path" FORCE)
  set(BSON_LIBS_DIRECTORY ${BSON_LIB_DIR} CACHE INTERNAL "Bson library path" FORCE)
  set(EMHASHMAP_INCLUDE_DIRECTORY ${EMHASHMAP_INCLUDE_DIRECTORY} CACHE INTERNAL "Emhashmap include path" FORCE)
  set(EMHASHMAP_LIBS_DIRECTORY ${EMHASHMAP_LIB_DIR} CACHE INTERNAL "Emhashmap library path" FORCE)

  message(STATUS "Found Bson: ${BSON_INCLUDE_DIRECTORY}")
  message(STATUS "Found Emhashmap: ${EMHASHMAP_INCLUDE_DIRECTORY}")
endif()

mark_as_advanced(BSON_LIB BSON_OBJECT_INCLUDE BSON_UTIL_INCLUDE BSON_ARRAY_INCLUDE)
mark_as_advanced(EMHASHMAP_INCLUDE_DIRECTORY EMHASHMAP_LIB)
