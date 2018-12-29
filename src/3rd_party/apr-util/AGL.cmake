set(CONFIGURE_FLAGS
  "--host=x86_64-aglsdk-linux"
  "--with-apr=${APR_PREFIX_DIRECTORY}"
  "--with-expat-source=${EXPAT_SOURCE_DIRECTORY}"
  "--with-expat-build=${EXPAT_BUILD_DIRECTORY}"
)

add_custom_command(OUTPUT ${APR_UTIL_BUILD_DIRECTORY}/Makefile
  COMMAND ${APR_UTIL_SOURCE_DIRECTORY}/configure ${CONFIGURE_FLAGS}
  DEPENDS libapr-1
  DEPENDS expat
  WORKING_DIRECTORY ${APR_UTIL_BUILD_DIRECTORY}
)