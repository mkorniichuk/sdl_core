set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}")

set(BOOST_FIND_VERSION 1.66.0)
set(BOOST_USE_SYSTEM_PATH 0)
find_package(Boost)

if ((BOOST_FOUND OR NO_REBUILD_3RD_PARTY) AND
    NOT FORCE_3RD_PARTY)

  add_custom_target(Boost)
else()
  message(STATUS "Did not find boost. Downloading and installing boost 1.66")

  set(BOOST_SOURCE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/boost_src)
  set(BOOST_INCLUDE_DIRECTORY ${BOOST_SOURCE_DIRECTORY}/ CACHE INTERNAL "Boost include path" FORCE)
  set(BOOST_LIBS_DIRECTORY ${BOOST_SOURCE_DIRECTORY}/stage/lib/ CACHE INTERNAL "Boost library path" FORCE)

  include(${TARGET_PLATFORM})
endif()
