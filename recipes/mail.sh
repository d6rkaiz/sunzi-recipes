# mail server setup recipes
# requires: mysql.sh
#
if ! sunzi.installed "postfix"; then
    sunzi.mute "apt-get install -y postfix postfix-mysql"
fi
if ! sunzi.installed "dovecot-core"; then
    sunzi.mute "apt-get install -y dovecot-core dovecot-common dovecot-imapd dovecot-mysql dovecot-sieve"
fi
if ! sunzi.installed "opendkim"; then
    sunzi.mute "apt-get install -y libopendkim7 opendkim opendkim-tools"
fi
if ! sunzi.installed "postfix-policyd-spf-python"; then
    sunzi.mute "apt-get install -y postfix-policyd-spf-python"
fi
if sunzi.installed "exim4"; then
    sunzi.mute "apt-get -y purge exim4 exim4-base exim4-config exim4-daemon-light"
    sunzi.mute "apt-get -y autoremove"
fi
