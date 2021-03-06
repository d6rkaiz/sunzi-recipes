# php provision

if [ "$sunzi_pkg" = 'apt-get' ]; then
    cnfdir='/etc/nginx/conf.d/'
    sitedir='/etc/nginx/sites-available/'
else
    exit;
fi

if ! sunzi.installed "nginx"; then
    sunzi.install "nginx"
fi

if ! sunzi.installed "php5-common"; then
    sunzi.mute "apt-get install -qqy php5 php5-common php5-apc php5-gd php5-fpm php5-cli"
    if sunzi.installed "mysql-server-5.6"; then
        if ! sunzi.installed "php5-mysql"; then
            sunzi.install "php5-mysql"
        fi
    fi
    echo "PHP5-FPM configuration setup.."
    cnf="php.cnf"
    targetfile=${cnfdir}${cnf}
    rm -f $targetfile
    cat >> $targetfile <<EOM
index index.php index.html index.htm;

# upstream to abstract backend connection for PHP.
upstream php {
    server unix:/var/run/php5-fpm.sock;
}
EOM
    site='phpsample'
    targetfile=${sitedir}${site}
    rm -f $targetfile
    cat >> $targetfile <<'EOM'
# sample php sites
server {
    server_name _;
    root /var/www;

    location / {
        try_files $uri $uri/index.php?$args;
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        #NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini

        include fastcgi_params;
        fastcgi_index index.php;
        fastcgi_intercept_errors on;
        fastcgi_pass php;
    }
}
EOM
fi
