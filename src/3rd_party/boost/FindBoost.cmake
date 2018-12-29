if (BOOST_FOUND)
  message(STATUS "Found Boost: ${BOOST_INCLUDE_DIRECTORY} (found version \"${BOOST_VERSION}\")")
  return()
endif()

if (NOT DEFINED BOOST_USE_SYSTEM_PATH)
  set(BOOST_USE_SYSTEM_PATH 1)
endif()

set(Boost_FOUND 1)

###########################
# Looking for Boost libraries
###########################

if (DEFINED BOOST_FIND_VERSION)
  set(_Boost_LIB_SUFFIX ".so.${BOOST_FIND_VERSION}")
endif()

find_library(BOOST_SYSTEM_LIBRARY
  NAMES
    boost_system${_Boost_LIB_SUFFIX}
    libboost_system${_Boost_LIB_SUFFIX}
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX}
  PATH_SUFFIXES
    lib
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (BOOST_USE_SYSTEM_PATH)
  find_library(BOOST_SYSTEM_LIBRARY
    NAMES
      boost_system${_Boost_LIB_SUFFIX}
      libboost_system${_Boost_LIB_SUFFIX}
    PATH_SUFFIXES
      lib
  )
endif()
message(STATUS "Boost: libboost_system.so => ${BOOST_SYSTEM_LIBRARY}")

find_library(BOOST_FILESYSTEM_LIBRARY
  NAMES
    boost_filesystem${_Boost_LIB_SUFFIX}
    libboost_filesystem${_Boost_LIB_SUFFIX}
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX}
  PATH_SUFFIXES
    lib
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (BOOST_USE_SYSTEM_PATH)
find_library(BOOST_FILESYSTEM_LIBRARY
  NAMES
    boost_filesystem${_Boost_LIB_SUFFIX}
    libboost_filesystem${_Boost_LIB_SUFFIX}
  PATH_SUFFIXES
    lib
)
endif()
message(STATUS "Boost: libboost_filesystem.so => ${BOOST_FILESYSTEM_LIBRARY}")

find_library(BOOST_DATE_TIME_LIBRARY
  NAMES
    boost_date_time${_Boost_LIB_SUFFIX}
    libboost_date_time${_Boost_LIB_SUFFIX}
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX}
  PATH_SUFFIXES
    lib
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (BOOST_USE_SYSTEM_PATH)
find_library(BOOST_DATE_TIME_LIBRARY
  NAMES
    boost_date_time${_Boost_LIB_SUFFIX}
    libboost_date_time${_Boost_LIB_SUFFIX}
  PATH_SUFFIXES
    lib
)
endif()
message(STATUS "Boost: libboost_date_time.so => ${BOOST_DATE_TIME_LIBRARY}")

find_library(BOOST_THREAD_LIBRARY
  NAMES
    boost_thread${_Boost_LIB_SUFFIX}
    libboost_thread${_Boost_LIB_SUFFIX}
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX}
  PATH_SUFFIXES
    lib
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (BOOST_USE_SYSTEM_PATH)
find_library(BOOST_THREAD_LIBRARY
  NAMES
    boost_thread${_Boost_LIB_SUFFIX}
    libboost_thread${_Boost_LIB_SUFFIX}
  PATH_SUFFIXES
    lib
)
endif()
message(STATUS "Boost: libboost_thread.so => ${BOOST_THREAD_LIBRARY}")

unset(_Boost_LIB_SUFFIX)

###########################

###########################
# Looking for Boost headers
###########################

find_path(BOOST_FILESYSTEM_INCLUDE
  NAMES
    filesystem.hpp
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX}
  PATH_SUFFIXES
    include
    include/boost
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (BOOST_USE_SYSTEM_PATH)
find_path(BOOST_FILESYSTEM_INCLUDE
  NAMES
    filesystem.hpp
  PATH_SUFFIXES
    include
    include/boost
)
endif()
message(STATUS "Boost: filesystem.hpp => ${BOOST_FILESYSTEM_INCLUDE}")

find_path(BOOST_DATE_TIME_INCLUDE
  NAMES
    date_time.hpp
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX}
  PATH_SUFFIXES
    include
    include/boost
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (BOOST_USE_SYSTEM_PATH)
find_path(BOOST_DATE_TIME_INCLUDE
  NAMES
    date_time.hpp
  PATH_SUFFIXES
    include
    include/boost
)
endif()
message(STATUS "Boost: date_time.hpp => ${BOOST_DATE_TIME_INCLUDE}")

find_path(BOOST_THREAD_INCLUDE
  NAMES
    thread.hpp
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX}
  PATH_SUFFIXES
    include
    include/boost
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (BOOST_USE_SYSTEM_PATH)
find_path(BOOST_THREAD_INCLUDE
  NAMES
    thread.hpp
  PATH_SUFFIXES
    include
    include/boost
)
endif()
message(STATUS "Boost: thread.hpp => ${BOOST_THREAD_INCLUDE}")

###########################

###########################
# Check components
###########################

if (BOOST_SYSTEM_LIBRARY AND
    BOOST_FILESYSTEM_LIBRARY AND
    BOOST_DATE_TIME_LIBRARY AND
    BOOST_THREAD_LIBRARY AND
    BOOST_FILESYSTEM_INCLUDE AND
    BOOST_DATE_TIME_INCLUDE AND
    BOOST_THREAD_INCLUDE)
  get_filename_component(BOOST_SYSTEM_LIBRARY_DIR ${BOOST_SYSTEM_LIBRARY} DIRECTORY)
  get_filename_component(BOOST_FILESYSTEM_LIBRARY_DIR ${BOOST_FILESYSTEM_LIBRARY} DIRECTORY)
  get_filename_component(BOOST_DATE_TIME_LIBRARY_DIR ${BOOST_DATE_TIME_LIBRARY} DIRECTORY)
  get_filename_component(BOOST_THREAD_LIBRARY_DIR ${BOOST_THREAD_LIBRARY} DIRECTORY)

  if (NOT (${BOOST_SYSTEM_LIBRARY_DIR} STREQUAL ${BOOST_FILESYSTEM_LIBRARY_DIR}) OR
      NOT (${BOOST_SYSTEM_LIBRARY_DIR} STREQUAL ${BOOST_DATE_TIME_LIBRARY_DIR}) OR
      NOT (${BOOST_SYSTEM_LIBRARY_DIR} STREQUAL ${BOOST_THREAD_LIBRARY_DIR}))
    message(WARNING "Please, take a look at Boost library directories: they are not the same for different components.")
    set(Boost_FOUND 0)
  else()
    set(Boost_LIBRARY_DIRECTORY ${BOOST_SYSTEM_LIBRARY_DIR})
  endif()

  if (NOT (${BOOST_FILESYSTEM_INCLUDE} STREQUAL ${BOOST_THREAD_INCLUDE}) OR
      NOT (${BOOST_FILESYSTEM_INCLUDE} STREQUAL ${BOOST_DATE_TIME_INCLUDE}))
    message(WARNING "Please, take a look at Boost include directories: they are not the same for different components.")
    set(Boost_FOUND 0)
  else()
    set(Boost_INCLUDE_DIRECTORY ${BOOST_FILESYSTEM_INCLUDE})
  endif()

  ###########################
  # Headers version check
  ###########################

  file(STRINGS "${BOOST_FILESYSTEM_INCLUDE}/version.hpp" _boost_VERSION_HPP_CONTENTS REGEX "#define BOOST_VERSION ")
  string(REGEX MATCH "#define BOOST_VERSION ([0-9]+)" _Boost_VERSION ${_boost_VERSION_HPP_CONTENTS})
  unset(_boost_VERSION_HPP_CONTENTS)

  if (_Boost_VERSION STREQUAL "")
    message(WARNING "Boost version cannot be defined properly from ${BOOST_FILESYSTEM_INCLUDE}/version.hpp")
    set(Boost_FOUND 0)
  endif()

  math(EXPR Boost_MAJOR_VERSION "${_Boost_VERSION} / 100000")
  math(EXPR Boost_MINOR_VERSION "${_Boost_VERSION} / 100 % 1000")
  math(EXPR Boost_SUBMINOR_VERSION "${_Boost_VERSION} % 100")
  unset(_Boost_VERSION)

  set(Boost_VERSION "${Boost_MAJOR_VERSION}.${Boost_MINOR_VERSION}.${Boost_SUBMINOR_VERSION}")
  if (Boost_VERSION VERSION_LESS BOOST_FIND_VERSION)
    message(WARNING "Detected version of Boost is too old (${Boost_VERSION}). Requested version was ${BOOST_FIND_VERSION}")
    set(Boost_FOUND 0)
  endif()

  ###########################
else()
  message(STATUS "Failed to find Boost components.")
  set(Boost_FOUND 0)
endif()

if (Boost_FOUND)
  set(BOOST_FOUND ${Boost_FOUND} CACHE INTERNAL "Boost found" FORCE)
  set(BOOST_INCLUDE_DIRECTORY ${Boost_INCLUDE_DIRECTORY} CACHE INTERNAL "Boost include path" FORCE)
  set(BOOST_LIBS_DIRECTORY ${Boost_LIBRARY_DIRECTORY} CACHE INTERNAL "Boost library path" FORCE)
  set(BOOST_VERSION ${Boost_VERSION} CACHE INTERNAL "Boost version" FORCE)

  message(STATUS "Found Boost: ${Boost_INCLUDE_DIRECTORY} (found version \"${BOOST_VERSION}\")")
endif()

mark_as_advanced(BOOST_SYSTEM_LIBRARY)
mark_as_advanced(BOOST_FILESYSTEM_LIBRARY BOOST_FILESYSTEM_INCLUDE)
mark_as_advanced(BOOST_DATE_TIME_LIBRARY BOOST_DATE_TIME_INCLUDE)
mark_as_advanced(BOOST_THREAD_LIBRARY BOOST_THREAD_INCLUDE)
