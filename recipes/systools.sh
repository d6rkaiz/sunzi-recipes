# system tools

sunzi.install "telnet dnsutils dstat"

if ! sunzi.installed "sysstat"; then
  sunzi.install 'sysstat'
  sed -i 's/ENABLED="false"/ENABLED="true"/' /etc/default/sysstat
  service sysstat restart
fi
if ! sunzi.installed "ntp"; then
  sunzi.install 'ntp'
  service ntp stop
  mv /etc/ntp.conf /etc/ntp.conf.sunzi
  cat >> /etc/ntp.conf <<EOM
# /etc/ntp.conf

driftfile /var/lib/ntp/ntp.drift

statistics loopstats peerstats clockstats
filegen loopstats file loopstats type day enable
filegen peerstats file peerstats type day enable
filegen clockstats file clockstats type day enable

server ntp1.jst.mfeed.ad.jp
server ntp2.jst.mfeed.ad.jp
server ntp3.jst.mfeed.ad.jp

restrict -4 default kod notrap nomodify nopeer noquery
restrict -6 default kod notrap nomodify nopeer noquery

restrict 127.0.0.1
restrict ::1

EOM
  service ntp start
fi
