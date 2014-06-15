# mysql provision
# $1: db password

set_passwd () {
    q="/tmp/sqlquery.$$"
    echo "" > $q
    for host in localhost 127.0.0.1
    do
      echo "set password for root@'$host'=password('$1');" >> $q
    done
    mysql -uroot < $q
    echo -n " set password for root: "
    if [ $? -eq 0 ]; then
        echo "success"
    else
        echo "failed!"
    fi
    rm -f $q
}

query () {
    q="/tmp/sqlquery.$$"
    echo "$1" > $q
    mysql -uroot -p$2 < $q
    if [ $? -eq 0 ]; then
        echo " Success"
    else
        echo " Failed!"
    fi
    rm -f $q
}

if [ "$sunzi_pkg" = 'apt-get' ]; then
    targetdir='/etc/mysql/conf.d/'
else
    exit;
fi

if ! sunzi.installed "mysql-server"; then
    sunzi.install "mysql-server-5.6"
    sunzi.install "libmysqlclient18"
    sunzi.install "libmysqlclient-dev"
    if sunzi.installed "php5-common"; then
        if ! sunzi.installed "php5-mysql"; then
            sunzi.install "php5-mysql"
        fi
    fi

    echo "mysql secure setup start"
    dbpassword=$1
    echo "set to root password"
    set_passwd $dbpassword
    echo "remove anonymous user"
    query "DELETE FROM mysql.user WHERE user='';" $dbpassword
    echo "remove remote access user"
    query "DELETE FROM mysql.user WHERE user='root' AND host NOT IN ('localhost','127.0.0.1');" $dbpassword
    echo "drop test database"
    query "DROP DATABASE IF EXISTS test;" $dbpassword
    echo "remove privileges test database"
    query "DELETE FROM mysql.db WHERE db='test' OR db='test%';" $dbpassword
    echo "flush privileges"
    query "FLUSH PRIVILEGES;" $dbpassword

    echo "setup my.cnf params add/change"
    echo " >> prepare:innodb_fast_shutdown variables change"
    query "SET GLOBAL innodb_fast_shutdown = 0" $dbpassword

    echo " >> prepare:mysql service stop"
    sunzi.mute "service mysql stop"

    echo " >> prepare:mysql ib_logfile delete"
    sunzi.mute "rm -f /var/lib/mysql/ib_logfile?"

    echo " >> innnodb & characterset configuration setup.."
    sunzi.mute "mkdir -p $targetdir"
    cnf="mysql_innodb.cnf"
    targetfile=${targetdir}${cnf}
    rm -f $targetfile
    cat >> $targetfile <<EOM
[mysqld]
#
# * InnoDB
#
# Read the manual for more InnoDB related options. There are many!

innodb_buffer_pool_size = 32M
innodb_additional_mem_pool_size = 2M
innodb_log_file_size = 8M
innodb_log_buffer_size = 8M
innodb_flush_log_at_trx_commit = 2
innodb_lock_wait_timeout = 20
innodb_file_per_table = true
innodb_flush_method = O_DIRECT
innodb_doublewrite = false
innodb_large_prefix
innodb_file_format = Barracuda

default-storage-engine=InnoDB
EOM

    cnf="mysql_characterset.cnf"
    targetfile=${targetdir}${cnf}
    rm -f $targetfile
    cat >> $targetfile <<EOM
#
# mysql characterset
#
# Reference URL:
#   http://mathiasbynens.be/notes/mysql-utf8mb4
#
[client]
default-character-set = utf8mb4

[mysql]
default-character-set = utf8mb4

[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
EOM
    sunzi.mute "service mysql start"
    query "show variables like 'innodb_version'" $dbpassword
    echo "setup done."
fi
