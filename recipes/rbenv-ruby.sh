# rbenv
# $1: ruby version

git_pull()
{
    pushd $1
    git pull
    popd
}

echo "rbenv setup start."
if [ -d /usr/local/rbenv ]; then
    echo 'rbenv already installed.'
    echo 'rbenv update start.'
    git_pull "/usr/local/rbenv"
    git_pull "/usr/local/rbenv/plugins/ruby-build"
    echo 'rbenv update done.'
else
    echo 'rbenv system wide installing.'
    git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv
    git clone git://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
    chmod -R g+rwxXs /usr/local/rbenv
    echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
    echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
    echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
fi
echo "rbenv setup done"
echo ""
echo "ruby $1 setup start"
if [ ! -d /usr/local/rbenv ]; then
    echo 'rbenv is not installed, skiping...'
else
    if ! which rbenv > /dev/null; then
        if [ -f /etc/profile.d/rbenv.sh ]; then
            source /etc/profile.d/rbenv.sh
        else
            echo "rbenv setup is failure. ruby setup is aborting..."
            exit
        fi
    fi
    if [ -f ~/.gemrc ]; then
        echo 'gems already setup, skiping...'
    else
        echo 'gem: --no-ri --no-rdoc' > ~/.gemrc
        echo 'gems setup done.'
    fi
    if [ -d /usr/local/rbenv/versions/$1 ]; then
        echo "ruby $1 is already installed, skiping..."
    else
        echo "Compiling Ruby. take a while..."
        rbenv install $1
        rbenv global $1
        sunzi.mute "gem update --system"
        sunzi.mute "gem install bundler foreman"
        rbenv rehash
    fi
fi
echo "ruby $1 setup done"
