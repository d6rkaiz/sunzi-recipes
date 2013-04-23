# rbenv
# $1: ruby version

if [ ! -d /usr/local/rbenv ]; then
    echo 'rbenv is not installed, skiping...'
else
    echo "Compiling Ruby. take a while..."
    rbenv install $1
    rbenv global $1
    rbenv rehash
fi
