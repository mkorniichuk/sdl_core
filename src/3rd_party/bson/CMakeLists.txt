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
