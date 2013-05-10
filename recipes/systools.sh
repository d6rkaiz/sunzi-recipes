# system tools

sunzi.install "telnet dnsutils dstat"

if ! sunzi.installed "sysstat"; then
  sunzi.install 'sysstat'
  sed -i 's/ENABLED="false"/ENABLED="true"/' /etc/default/sysstat
  service sysstat restart
fi
