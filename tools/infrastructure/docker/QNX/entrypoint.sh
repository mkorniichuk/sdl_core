#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}

EX_CODE=$(id -u developer > /dev/null 2&>1 || echo $?)
if [[ $EX_CODE -ne $? ]]; then
    useradd --shell /bin/bash -u $USER_ID -o -c "" developer
    echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    chown -R developer:developer /home/developer
    export HOME=/home/developer
fi

echo "Welcome to developer_qnx:build!"
printf "Starting with user developer, UID : $USER_ID \n\n"
echo   "    You may run sudo without password"
printf "    You may run GUI applications in container\n\n"

[ -e /opt/startup/ ] && for script in /opt/startup/*; do bash $script ; done

/bin/su -c $@ - developer
