# develop tools

applist="git build-essential libreadline6-dev zlib1g-dev libssl-dev libxml2-dev libxslt1-dev"
for pkg in ${applist}
do
    sunzi.install $pkg
done
