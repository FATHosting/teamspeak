#!/bin/bash

home_dir=/home/teamspeak/teamspeak3-server_linux_amd64
backup_vol=/home/teamspeak/backup

# docker volumes are mounted as root
# chown them to the correct user after mount
chown teamspeak:teamspeak ${backup_vol}

# restore all data from backup volume if any
if [ "$(ls -A ${backup_vol})" ]; then
    echo ">> Restoring backup data from backup volume..."
    rsync -aP ${backup_vol}/ ${home_dir}
fi

# launch lsyncd to sync container -> volume
lsyncd /etc/lsyncd/lsyncd.conf.lua

export LD_LIBRARY_PATH=${home_dir}
cd ${home_dir}

echo ">> Starting TS3 server..."
# execute ts3_server as correct user
exec gosu teamspeak "$@"
