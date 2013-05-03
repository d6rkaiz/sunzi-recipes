# mysql provision

query () {
    q="/tmp/sqlquery.$$"
    echo "$1" > $q
    mysql -uroot < $q
    if [ $? -eq 0 ]; then
        echo " Success"
    else
        echo " Failed!"
    fi
    rm -f $q
}

if [ "$sunzi_pkg" = 'apt-get' ]; then
    targetdir='/etc/mysql/conf.d/'
#elif [ "$sunzi_pkg" = 'yum' ]; then
#    targetdir='/etc/mysql/'
#   if ! grep -Fq '!includedir /etc/mysql/' /etc/my.cnf; then
#       echo '!includedir /etc/mysql/' >> /etc/my.cnf
#   fi
else
    exit;
fi

sunzi.install "mysql-server-5.5 libmysqlclient18 libmysqlclient-dev"
query "SET GLOBAL innodb_fast_shutdown = 0"
sunzi.mute "service mysql stop"
sunzi.mute "mkdir -p $targetdir"
sunzi.mute "rm -f /var/lib/mysql/ib_logfile?"
echo "MySQL innnodb & characterset configuration setup.."
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

default-storage-engine=InnoDB
EOM

cnf="mysql_characterset.cnf"
targetfile=${targetdir}${cnf}
rm -f $targetfile
cat >> $targetfile <<EOM
[client]
default-character-set=utf8

[mysql]
default-character-set=utf8

[mysqld]
character-set-server=utf8
EOM
sunzi.mute "service mysql start"
query "show variables like 'innodb_version'"

echo "mysql secure setup start"
echo "remove anonymous user"
query "DELETE FROM mysql.user WHERE user='';"
echo "remove remote access user"
query "DELETE FROM mysql.user WHERE user='root' AND host NOT IN ('localhost','127.0.0.1','::1');"
echo "drop test database"
query "DROP DATABASE IF EXISTS test;"
echo "remove privileges test database"
query "DELETE FROM mysql.db WHERE db='test' OR db='test\\_%';"
echo "flush privileges"
query "FLUSH PRIVILEGES;"
echo ""
echo "YOU MUST BE SET MySQL PASSWORD!!"
