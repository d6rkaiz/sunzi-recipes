echo "disable IPv6"
sed -i 's/^::1/#::1/' /etc/hosts
sed -i 's/^ff02/#ff02/' /etc/hosts
sed -i 's/^#ListenAddress\ 0.0.0.0/ListenAddress\ 0.0.0.0/' /etc/ssh/sshd_config
if [ -f /etc/default/ntp ]; then
    sed -i "s/^NTPD_OPTS='-g'/NTPD_OPTS='-4 -g'/" /etc/default/ntp
fi
echo net.ipv6.conf.all.disable_ipv6=1 > /etc/sysctl.d/disableipv6.conf
echo "done."
echo ""
echo "YOU MUST BE REBOOT!!"
