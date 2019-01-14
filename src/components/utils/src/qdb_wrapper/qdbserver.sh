# This script star QDB server for SDL
# Need superuser to start qdb
# This script must be executed in the same directory with smartDeviceLink.ini
POLICY_PATH=$PWD/$(sed -n 's/^AppStorageFolder = //p' $PWD/smartDeviceLink.ini)
# Creating storage for the policy
if [ ! -d $POLICY_PATH ] ; then
   mkdir -p $POLICY_PATH
fi
# Run PPS service
if ! pidin | grep pps > /dev/null
then
   if [ -d /pps ] ; then
   	  rm -r /pps
   fi
   pps
fi
# Checking PPS configuration path
if [ ! -d /pps/qnx/qdb/config ] ; then
   mkdir -p /pps/qnx/qdb/config
   mkdir -p /pps/qnx/qdb/status
fi
# Config init for policy &  Run QDB 
# If no tempstore option (-o tempstore) is specified on the command line,
# the QDB uses the environment variable TMPDIR to obtain the location it should use for temporary storage.
# If all the above conditions are met, the QDB sets the internal temporary storage to the value of TMPDIR.
# If any of the above conditions are not met, the QDB logs errors to the slog and fails to start up.
echo Filename::$POLICY_PATH/policy > /pps/qnx/qdb/config/policy
if ! pidin | grep qdb > /dev/null
then
   qdb -Otempstore=/tmp
fi
# Since there is no guaranteed init order for QDB, we have to wait for it
if [ ! -d /dev/qdb ] ; then
   waitfor /dev/qdb
fi
