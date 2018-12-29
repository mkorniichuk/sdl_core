#!/bin/bash

#
#   Helper functions for apache-log4cxx versioning
#

DEBUG() {
    echo "$@"
}

AppendCommitHash() {
    LOG4CXX_SOURCE_DIRECTORY=$1
    LOG4CXX_LIBS_DIRECTORY=$2
    COMMIT_HASH_FILE=/tmp/commit_hash
    cd $LOG4CXX_SOURCE_DIRECTORY && git log --pretty=format:%H -1 . 1>$COMMIT_HASH_FILE 2>/dev/null
    if [[ -s $COMMIT_HASH_FILE ]]; then
        objcopy --add-section .commit_hash=$COMMIT_HASH_FILE ${LOG4CXX_LIBS_DIRECTORY%/}/liblog4cxx.so ${LOG4CXX_LIBS_DIRECTORY%/}/liblog4cxx.so 1>/dev/null 2>&1
    fi
    rm $COMMIT_HASH_FILE
}

IsActualVersion() {
    LOG4CXX_SOURCE_DIRECTORY=$1
    LOG4CXX_LIBS_DIRECTORY=$2
    INSTALLED_VERSION=$(readelf -p .commit_hash ${LOG4CXX_LIBS_DIRECTORY%/}/liblog4cxx.so  2>/dev/null | awk 'NR==3 {print $NF}')
    CURRENT_VERSION=$(cd $LOG4CXX_SOURCE_DIRECTORY && git log --pretty=format:%H -1 . 2>/dev/null)
    if [[ $INSTALLED_VERSION == $CURRENT_VERSION ]]; then
        echo "TRUE"
    else
        echo "FALSE"
    fi
}


      #   COMMAND /bin/bash -c \"cd ${CMAKE_CURRENT_SOURCE_DIR} &&
      #                          grep .commit_hash ${3RD_PARTY_INSTALL_PREFIX_ARCH}/lib/liblog4cxx.so 1>/dev/null 2>&1\;
      #                          if [ \\$$? == 0 ]\; then
      #                            VAR1=\\$$\( readelf -p .commit_hash ${3RD_PARTY_INSTALL_PREFIX_ARCH}/lib/liblog4cxx.so 2>/dev/null\)\;
      #                            VAR1=\\$$\(echo \\$$VAR1 | awk '{print \\$$NF}'\)\;
      #                            VAR2=-1\;
      #                            cd ${CMAKE_CURRENT_SOURCE_DIR}\;
      #                            git log . 1>/dev/null 2>&1\;
      #                            echo \\$$?\;
      #                            echo ${3RD_PARTY_SOURCE_DIRECTORY}/apache-log4cxx/apache-log4cxx-0.10.0\;
      #                            if [ \\$$? == 0 ]; then
      #                                echo LOLKEK\;
      #                                VAR2=\\$$\(git log --pretty=\"format:%H\" -1 ${3RD_PARTY_SOURCE_DIRECTORY}/apache-log4cxx/apache-log4cxx-0.10.0\)\;
      #                                echo \\$$VAR2\;
      #                            fi\;
      #                            echo \\$$VAR1\;
      #                            echo \\$$VAR2\;
      #                            if [ \\$$VAR1 != \\$$VAR2 ]\; then
      #                              echo " Need to rebuild logger. " \;
      #                              cd ${3RD_PARTY_BINARY_DIRECTORY}\;
      #                              make\;
      #                            else
      #                              echo " Logger is actual. " \;
      #                            fi\;
      #                          else
      #                            echo " Need to build logger. " \;
      #                            cd ${3RD_PARTY_BINARY_DIRECTORY}\;
      #                            make\;
      #                          fi\"
      #   WORKING_DIRECTORY ${3RD_PARTY_BINARY_DIRECTORY}

            #   COMMAND /bin/bash -c \"echo 3; cd ${CMAKE_CURRENT_SOURCE_DIR} &&
      #                          grep .commit_hash ${3RD_PARTY_INSTALL_PREFIX_ARCH}/lib/liblog4cxx.so 1>/dev/null 2>&1\;
      #                          if [ \\$$? == 0 ]\; then
      #                            VAR1=\\$$\( readelf -p .commit_hash ${3RD_PARTY_INSTALL_PREFIX_ARCH}/lib/liblog4cxx.so 2>/dev/null\)\;
      #                            VAR1=\\$$\(echo \\$$VAR1 | awk '{print \\$$NF}'\)\;
      #                            VAR2=-1\;
      #                            cd ${CMAKE_CURRENT_SOURCE_DIR}\;
      #                            git log . 1>/dev/null 2>&1\;
      #                            if [ \\$$? == 0 ]; then
      #                                VAR2=\\$$\(git log --pretty=\"format:%H\" -1 ${3RD_PARTY_SOURCE_DIRECTORY}/apache-log4cxx/apache-log4cxx-0.10.0\)\;
      #                            fi\;
      #                            if [ \\$$VAR1 != \\$$VAR2 ]\; then
      #                              USE_DEFAULT_3RD_PARTY_PATH=${USE_DEFAULT_3RD_PARTY_PATH}\;
      #                              if [ \\$$USE_DEFAULT_3RD_PARTY_PATH == "true" ]\; then
      #                                cd ${3RD_PARTY_BINARY_DIRECTORY}\;
      #                                sudo -k \;
      #                                sudo make install\;
      #                              else
      #                                cd ${3RD_PARTY_BINARY_DIRECTORY}\;
      #                                make install\;
      #                              fi\;
      #                            fi\;
      #                          else
      #                            USE_DEFAULT_3RD_PARTY_PATH=${USE_DEFAULT_3RD_PARTY_PATH}\;
      #                            if [ \\$$USE_DEFAULT_3RD_PARTY_PATH == "true" ]\; then
      #                              cd ${3RD_PARTY_BINARY_DIRECTORY}\;
      #                              sudo -k \;
      #                              sudo make install\;
      #                            else
      #                              cd ${3RD_PARTY_BINARY_DIRECTORY}\;
      #                              make install\;
      #                            fi\;
      #                          fi\"
      #   DEPENDS 3rd_party_logger
      #   WORKING_DIRECTORY ${3RD_PARTY_BINARY_DIRECTORY}


"$@"