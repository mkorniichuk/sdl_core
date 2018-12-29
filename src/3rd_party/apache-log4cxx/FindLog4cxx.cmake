if (LOG4CXX_FOUND)
  message(STATUS "Found Log4cxx: ${LOG4CXX_INCLUDE_DIR}")
  return()
endif()

if (NOT DEFINED LOG4CXX_USE_SYSTEM_PATH)
  set(LOG4CXX_USE_SYSTEM_PATH 1)
endif()

set (Log4cxx_FOUND 1)

###########################
# Looking for Apr headers
###########################

find_path(LOG4CXX_INCLUDE
  NAMES
    log4cxx/log4cxx.h
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX}
  PATH_SUFFIXES
    include
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (LOG4CXX_USE_SYSTEM_PATH)
  find_path(LOG4CXX_INCLUDE
    NAMES
      log4cxx.h
    PATH_SUFFIXES
      include
  )
endif()

###########################

###########################
# Looking for Apr libs
###########################

find_library(LOG4CXX_LIBRARY
  NAMES
    log4cxx
  PATHS
    ${3RD_PARTY_INSTALL_PREFIX_ARCH}
  PATH_SUFFIXES
    lib
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH
)
if (LOG4CXX_USE_SYSTEM_PATH)
  find_library(LOG4CXX_LIBRARY
    NAMES
      log4cxx
    PATH_SUFFIXES
      lib
  )
endif()

###########################

###########################
# Check components
###########################

if (LOG4CXX_INCLUDE AND LOG4CXX_LIBRARY)
  get_filename_component(LOG4CXX_LIBRARY_DIR ${LOG4CXX_LIBRARY} DIRECTORY)

  execute_process(
    COMMAND /bin/bash -c "bash ${CMAKE_CURRENT_SOURCE_DIR}/helpers.sh \
            IsActualVersion \
            ${LOG4CXX_SOURCE_DIRECTORY} \
            ${LOG4CXX_LIBRARY_DIR}"
    RESULT_VARIABLE IS_LOGGER_ACTUAL
  )
  if (NOT ${IS_LOGGER_ACTUAL})
    message(WARNING "Detected version of Log4CXX is too old.")
    set(Log4cxx_FOUND 0)
  endif()
else()
  message(STATUS "Failed to find Log4cxx components.")
  set(Log4cxx_FOUND 0)
endif()

if (Log4cxx_FOUND)
  set(LOG4CXX_FOUND ${Log4cxx_FOUND} CACHE INTERNAL "Log4cxx found" FORCE)
  set(LOG4CXX_INCLUDE_DIRECTORY ${LOG4CXX_INCLUDE} CACHE INTERNAL "Installation path of Log4CXX headers" FORCE)
  set(LOG4CXX_LIBS_DIRECTORY ${LOG4CXX_LIBRARY_DIR} CACHE INTERNAL "Installation path of Log4CXX libraries" FORCE)

  message(STATUS "Found Log4cxx: ${LOG4CXX_INCLUDE_DIRECTORY}")
endif()

mark_as_advanced(LOG4CXX_INCLUDE LOG4CXX_LIBRARY Log4cxx_FOUND)
