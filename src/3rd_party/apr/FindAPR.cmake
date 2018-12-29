if (APR_FOUND)
  message(STATUS "Found Apr: ${APR_INCLUDE_DIR}")
  return()
endif()

if (NOT DEFINED APR_USE_SYSTEM_PATH)
  set(APR_USE_SYSTEM_PATH 1)
endif()

set (Apr_FOUND 1)

###########################
# Looking for Apr headers
###########################

find_path(APR_INCLUDE
  NAMES
    apr_version.h
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX}
  PATH_SUFFIXES
    include
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (APR_USE_SYSTEM_PATH)
  find_path(APR_INCLUDE
    NAMES
      apr_version.h
    PATH_SUFFIXES
      include
  )
endif()

###########################

###########################
# Looking for Apr libs
###########################

find_library(APR_LIBRARY
  NAMES
    apr-1
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX_ARCH}
  PATH_SUFFIXES
    lib
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (APR_USE_SYSTEM_PATH)
  find_library(APR_LIBRARY
    NAMES
      apr-1
    PATH_SUFFIXES
      lib
  )
endif()

###########################

###########################
# Check components
###########################

if (APR_INCLUDE AND APR_LIBRARY)
  get_filename_component(APR_LIBRARY_DIR ${APR_LIBRARY} DIRECTORY)

  foreach(v MAJOR MINOR PATCH)
    file(STRINGS "${APR_INCLUDE}/apr_version.h" _apr_VERSION_H_CONTANT_${v} REGEX "#define APR_${v}_VERSION ")
    string(REGEX REPLACE "[A-z# ]" "" _apr_${v}_VERSION ${_apr_VERSION_H_CONTANT_${v}})
  endforeach()

  set(Apr_VERSION "${_apr_MAJOR_VERSION}.${_apr_MINOR_VERSION}.${_apr_PATCH_VERSION}")
  unset(_apr_MAJOR_VERSION)
  unset(_apr_MINOR_VERSION)
  unset(_apr_PATCH_VERSION)

  if (Apr_VERSION STREQUAL "")
    message(WARNING "Apr version could not be defined properly from ${APR_INCLUDE}/apr_version.h")
    set(Apr_FOUND 0)
  endif()

  if (Apr_VERSION VERSION_LESS APR_FIND_VERSION)
    message(WARNING "Detected version of Apr is too old (${Apr_VERSION}). Requested version was ${APR_FIND_VERSION}")
    set(Apr_FOUND 0)
  endif()

else()
  message(STATUS "Failed to find Apr components.")
  set(Apr_FOUND 0)
endif()

if (Apr_FOUND)
  set(APR_FOUND ${Apr_FOUND} CACHE INTERNAL "Apr found" FORCE)
  set(APR_INCLUDE_DIR ${APR_INCLUDE} CACHE INTERNAL "Apr include path" FORCE)
  set(APR_LIBRARY_DIR ${APR_LIBRARY_DIR} CACHE INTERNAL "Apr library path" FORCE)
  set(APR_VERSION ${Apr_VERSION} CACHE INTERNAL "Apr version" FORCE)

  message(STATUS "Found Apr: ${APR_INCLUDE_DIR} (found version \"${APR_VERSION}\")")
endif()

mark_as_advanced(APR_INCLUDE APR_LIBRARY Apr_VERSION Apr_FOUND)
