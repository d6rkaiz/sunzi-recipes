# rbenv

if [ -d /usr/local/rbenv ]; then
    echo 'rbenv already installed, skiping...'
else
    echo 'rbenv system wide installing.'
    git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv
    git clone git://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
    chmod -R g+rwxXs /usr/local/rbenv
    echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
    echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
    echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
fi
