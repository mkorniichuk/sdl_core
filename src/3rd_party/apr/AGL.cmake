set(CONFIGURE_FLAGS
    "--host=x86_64-aglsdk-linux"
    "ac_cv_file__dev_zero=yes"
    "ac_cv_func_setpgrp_void=yes"
    "apr_cv_process_shared_works=yes"
    "apr_cv_mutex_recursive=yes"
    "apr_cv_mutex_robust_shared=no"
    "apr_cv_tcp_nodelay_with_cork=no"
    "ac_cv_sizeof_struct_iovec=8"
)

add_custom_command(OUTPUT ${APR_BUILD_DIRECTORY}/Makefile
  COMMAND ${APR_SOURCE_DIRECTORY}/configure ${CONFIGURE_FLAGS}
  COMMAND ${CMAKE_COMMAND} -E copy include/apr.h ${APR_SOURCE_DIRECTORY}/include
  WORKING_DIRECTORY ${APR_BUILD_DIRECTORY}
)

add_custom_command(OUTPUT ${APR_BUILD_DIRECTORY}/include/private/apr_escape_test_char.h
  DEPENDS ${APR_BUILD_DIRECTORY}/Makefile
  COMMAND make include/private/apr_escape_test_char.h
  COMMAND ${CMAKE_COMMAND} -E copy include/private/apr_escape_test_char.h ${APR_SOURCE_DIRECTORY}/include/private
  WORKING_DIRECTORY ${APR_BUILD_DIRECTORY}
)
