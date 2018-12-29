#!/bin/bash

#
#   Helper functions for apache-log4cxx versioning.
#       Designed to be used from cmake.
#
#   Usage:
#       helpers.sh <COMMAND> <PARAMS>
#
#   Available commands:
#       * AppendCommitHash
#           Description:
#              Appends last commit hash of Log4CXX (by source directory) to the new .commit_hash section
#              of liblog4cxx.so
#           Params (ordered):
#               1. LOG4CXX_SOURCE_DIRECTORY - source directory of Log4CXX. last commit hash within this
#                   directory will be used to define version.
#               2. LOG4CXX_LIBS_DIRECTORY - directory containing built liblog4cxx.so (the file to be
#                   modified in order to contain so called library version).
#           Returns:
#               None
#           Note:
#               commit hash is stored to a temporary file: /tmp/commit_hash
#       *IsActualVersion
#           Description:
#              Compares versions based on last commit hash between liblog4cxx.so .commit_hash section
#              content and source directory last commit.
#           Params (ordered):
#               1. LOG4CXX_SOURCE_DIRECTORY - source directory of Log4CXX. last commit hash within this
#                   directory will be used to verify version.
#               2. LOG4CXX_LIBS_DIRECTORY - directory containing built liblog4cxx.so (the file with .commit_hash
#                   section to check library version).
#           Returns:
#               To the stdout:
#                  TRUE if version is actual, FALSE otherwise.
#
#   Examples:
#       helpers.sh AppendCommitHash /path/to/log4CXX/ /path/to/log4cxx.so
#       helpers.sh IsActualVersion /path/to/log4CXX/ /path/to/log4cxx.so
#

AppendCommitHash() {
    LOG4CXX_SOURCE_DIRECTORY=$1
    LOG4CXX_LIBS_DIRECTORY=$2
    COMMIT_HASH_FILE=/tmp/commit_hash
    if objdump -s -j .commit_hash ${LOG4CXX_LIBS_DIRECTORY%/}/liblog4cxx.so 1>/dev/null 2>&1; then
        return 0
    fi
    cd $LOG4CXX_SOURCE_DIRECTORY && git log --pretty=format:%H -1 . 1>$COMMIT_HASH_FILE
    objcopy --add-section .commit_hash=$COMMIT_HASH_FILE ${LOG4CXX_LIBS_DIRECTORY%/}/liblog4cxx.so ${LOG4CXX_LIBS_DIRECTORY%/}/liblog4cxx.so
    rm $COMMIT_HASH_FILE
}

IsActualVersion() {
    LOG4CXX_SOURCE_DIRECTORY=$1
    LOG4CXX_LIBS_DIRECTORY=$2
    INSTALLED_VERSION=$(readelf -p .commit_hash ${LOG4CXX_LIBS_DIRECTORY%/}/liblog4cxx.so | awk 'NR==3 {print $NF}')
    CURRENT_VERSION=$(cd $LOG4CXX_SOURCE_DIRECTORY && git log --pretty=format:%H -1 .)
    if [[ $INSTALLED_VERSION == $CURRENT_VERSION ]]; then
        return 1
    else
        return 0
    fi
}

"$@"
