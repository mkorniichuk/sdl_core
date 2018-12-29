if (APR_UTIL_FOUND)
  message(STATUS "Found Apr-Util: ${APR_UTIL_INCLUDE_DIRECTORY}")
  return()
endif()

if (NOT DEFINED APR_UTIL_USE_SYSTEM_PATH)
  set(APR_UTIL_USE_SYSTEM_PATH 1)
endif()

set (Apr_Util_FOUND 1)

###########################
if (APR_UTIL_FIND_VERSION)
  string(REGEX MATCHALL "([0-9]+)\\.([0-9]+)\\.([0-9]+)" _ ${APR_UTIL_FIND_VERSION})
  set(_apu_find_ver_major ${CMAKE_MATCH_1})
  set(_apu_find_ver_minor ${CMAKE_MATCH_2})
  set(_apu_find_ver_patch ${CMAKE_MATCH_3})
  set(_apr_util_lib_suffix "-${_apu_find_ver_major}.so.0.${_apu_find_ver_minor}.${_apu_find_ver_patch}")
else()
  set(_apr_util_lib_suffix "-1")
endif()

message(STATUS "==========================${_apr_util_lib_suffix}")

###########################
# Looking for Apr libs
###########################

find_library(APR_UTIL_LIBRARY
  NAMES
    aprutil${_apr_util_lib_suffix}
    libaprutil${_apr_util_lib_suffix}
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX_ARCH}
  PATH_SUFFIXES
    lib
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (APR_UTIL_USE_SYSTEM_PATH)
  find_library(APR_UTIL_LIBRARY
    NAMES
      aprutil${_apr_util_lib_suffix}
      libaprutil${_apr_util_lib_suffix}
    PATH_SUFFIXES
      lib
  )
endif()

###########################

###########################
# Check components
###########################

if (APR_UTIL_LIBRARY)
  get_filename_component(APR_UTIL_LIBRARY_DIR ${APR_UTIL_LIBRARY} DIRECTORY)

else()
  message(STATUS "Failed to find Apr util components.")
  set(Apr_Util_FOUND 0)
endif()

if (Apr_Util_FOUND)
  set(APU_FOUND ${Apr_Util_FOUND} CACHE INTERNAL "Apr util found" FORCE)
  set(APU_LIBRARY_DIR ${APR_UTIL_LIBRARY_DIR} CACHE INTERNAL "Apr util library path" FORCE)
  set(APU_VERSION ${Apr_util_VERSION} CACHE INTERNAL "Apr util version" FORCE)

  message(STATUS "Found Apr Util: ${APU_LIBRARY_DIR}")
endif()

mark_as_advanced(APU_INCLUDE_DIR APR_UTIL_LIBRARY APU_LIBRARY_DIR APU_VERSION APU_FOUND)
