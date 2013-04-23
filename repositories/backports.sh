# backports

if [ -f /etc/apt/sources.list.d/backports.list ]; then
  echo 'backports entry already exists'
else
  echo 'Adding Backports to the apt source list'
  echo 'deb http://ftp.jp.debian.org/debian-backports squeeze-backports main' > /etc/apt/sources.list.d/backports.list
fi
