# system tools

applist="telnet dnsutils dstat lsb-release ufw debian-goodies"
for pkg in ${applist}
do
    sunzi.install $pkg
done

if ! sunzi.installed "sysstat"; then
  sunzi.install 'sysstat'
  sed -i 's/ENABLED="false"/ENABLED="true"/' /etc/default/sysstat
  service sysstat restart
fi
