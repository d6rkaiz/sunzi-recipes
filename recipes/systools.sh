# system tools

sunzi.install "telnet"
sunzi.install "dnsutils"
sunzi.install "dstat"
sunzi.install "lsb-release"
sunzi.install "ufw"

if ! sunzi.installed "sysstat"; then
  sunzi.install 'sysstat'
  sed -i 's/ENABLED="false"/ENABLED="true"/' /etc/default/sysstat
  service sysstat restart
fi
