# rbenv
# $1: ruby version

if [ ! -d /usr/local/rbenv ]; then
    echo 'rbenv is not installed, skiping...'
else
    if ! which rbenv > /dev/null; then
        source /etc/profile.d/rbenv.sh
    fi
    if [ ! -d /usr/local/rbenv/versions/$1 ]; then
        echo "Compiling Ruby. take a while..."
        rbenv install $1
        rbenv global $1
        rbenv rehash
        sunzi.mute "gem update --system"
        sunzi.mute "gem install bundler"
    fi
    if [ -f ~/.gemrc ]; then
        echo 'gems already setup, skiping...'
    else
        echo 'gem: --no-ri --no-rdoc' > ~/.gemrc
    fi
fi
