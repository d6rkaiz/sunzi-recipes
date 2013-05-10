# date

if ! grep -Fq "Etc/UTC" /etc/timezone; then
  cat > /etc/timezone <<EOM
Etc/UTC
EOM
  dpkg-reconfigure -f noninteractive tzdata
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
