# system tools

sunzi.install "ntp telnet dnsutils sysstat dstat"

if sunzi.installed "sysstat"; then
  sed -i 's/ENABLED="false"/ENABLED="true"/' /etc/default/sysstat
  service sysstat restart
fi
