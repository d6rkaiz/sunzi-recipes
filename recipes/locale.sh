export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen --purge en_US.UTF-8
sed -i 's/^#LANG=/LANG=/' /etc/default/locale
dpkg-reconfigure -f noninteractive locales
