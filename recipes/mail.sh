if ! sunzi.installed "postfix"; then
    sunzi.install "postfix postfix-mysql"
fi
if ! sunzi.installed "dovecot"; then
    sunzi.install "dovecot-core dovecot-common dovecot-imapd dovecot-mysql dovecot-sieve"
fi
if sunzi.installed "exim4"; then
    sunzi.mute "apt-get -y purge exim4 exim4-base exim4-config exim4-daemon-light"
fi
