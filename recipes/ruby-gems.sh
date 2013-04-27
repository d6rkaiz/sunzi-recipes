# gems setup
# 

if [ ! -d /usr/local/rbenv ]; then
    echo 'rbenv is not installed, skiping...'
else
    echo "Compiling Ruby. take a while..."
    if which rbenv > /dev/null; then
        source /etc/profile.d/rbenv.sh
    fi
    if [ -f ~/.gemrc ]; then
        echo 'gems already setup, skiping...'
    else
        echo 'gem: --no-ri --no-rdoc' > ~/.gemrc
        gem update --system
        gem install bundler
    fi
fi
