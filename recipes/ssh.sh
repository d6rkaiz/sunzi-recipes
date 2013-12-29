# sshd
sed -i 's/^#PasswordAuthentication\ yes$/PasswordAuthentication\ no/' /etc/ssh/sshd_config
sed -i 's/^X11Forwarding\ yes$/X11Forwarding\ no/' /etc/ssh/sshd_config
