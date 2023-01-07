#!/bin/sh
#
#
hostKeyDir=/etc/ssh/keys

trap 'trap " " SIGTERM; kill 0; wait' SIGTERM SIGQUIT SIGINT

if [[ "$SSHD_DEBUG" == "true" ]] ; then
  SSHD_DEBUG="-e"
fi

# generate sshd host keys if not found
for keyType in ed25519 rsa ; do
  keyFile="$hostKeyDir/ssh_host_${keyType}_key"
  if [ ! -r "$keyFile" ] ; then
    # '-b 4096' will be ignored for ed25519
    ssh-keygen -N "" -t $keyType -b 4096 -f "$keyFile" < /dev/null
  fi
done

# generate user key cache
/usr/sbin/get_user_keys > /dev/null

# start sshd in non-daemon mode, in the background, and wait
/usr/sbin/sshd -D $SSHD_DEBUG &
wait
