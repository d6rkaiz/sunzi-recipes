# Nginx mainline

if [ -f /etc/apt/sources.list.d/nginx.list ]; then
  echo 'nginx mainline entry already exists'
else
  echo 'Adding nginx mainline to the apt source list'
  echo 'deb http://nginx.org/packages/mainline/debian/ wheezy nginx' > /etc/apt/sources.list.d/nginx.list
  echo 'deb-src http://nginx.org/packages/mainline/debian/ wheezy nginx' >> /etc/apt/sources.list.d/nginx.list
  wget http://nginx.org/keys/nginx_signing.key -O - 2> /dev/null | apt-key add -
fi
