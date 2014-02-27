export LANG=en_US.UTF-8
export LC_ALL=$LANG
locale-gen --purge $LANG
dpkg-reconfigure -f noninteractive locales && /usr/sbin/update-locale LANG=$LANG
