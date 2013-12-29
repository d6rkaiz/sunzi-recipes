echo "disable IPv6"

# hosts
sed -i 's/^::1/#::1/' /etc/hosts
sed -i 's/^ff02/#ff02/' /etc/hosts

# sshd listen address
sed -i 's/^#ListenAddress\ 0.0.0.0/ListenAddress\ 0.0.0.0/' /etc/ssh/sshd_config

# ntp boot options
if [ -f /etc/default/ntp ]; then
    sed -i "s/^NTPD_OPTS='-g'/NTPD_OPTS='-4 -g'/" /etc/default/ntp
fi

# ufw
if [ -f /etc/default/ufw ]; then
    sed -i 's/^IPV6=yes$/IPV6=no/' /etc/default/ufw
fi

# sysctl
echo net.ipv6.conf.all.disable_ipv6=1 > /etc/sysctl.d/disableipv6.conf

# complete
echo "done."
echo ""
echo "YOU MUST BE REBOOT!!"
