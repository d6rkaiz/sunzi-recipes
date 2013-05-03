# create deploy user
# $1: username

USER=$1

echo "Deploy User:${USER} create"
if [ ! -d /home/$USER ]; then
    sunzi.mute "useradd -m -k /etc/skel/ -g users -s /bin/bash $USER"
    mkdir /home/$USER/.ssh
    chmod 700 /home/$USER/.ssh
    chown -R $USER:users /home/$USER/.ssh
fi
if [ ! -f /etc/sudoers.d/$USER ]; then
    cat >> /etc/sudoers.d/$USER << EOM
$USER ALL=(ALL) NOPASSWD:ALL
EOM
    chmod 440 /etc/sudoers.d/$USER
fi
if ! grep -Fq "AllowUsers $USER" /etc/ssh/sshd_config; then
    echo "AllowUsers $USER" >> /etc/ssh/sshd_config
fi
sunzi.mute "service ssh restart"
