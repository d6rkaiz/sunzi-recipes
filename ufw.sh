# firewall

sunzi.install "ufw"
ufw logging off
ufw default deny
ufw limit 'OpenSSH'
yes|ufw enable
