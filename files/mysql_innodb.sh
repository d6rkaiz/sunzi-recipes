# mysql server InnoDB setting
#  for cheap memory & cheap log file size.

if [ "$sunzi_pkg" = 'apt-get' ]; then
    FILE_PATH = '/etc/mysql/conf.d/mysql_innodb.cnf'
#elif [ "$sunzi_pkg" = 'yum' ]; then
#    FILE_PATH = '/etc/mysql/mysql_innodb.cnf'
else
    exit;
fi

if [-f $FILE_PATH ]; then
  echo 'MySQL InnoDB already set up'
else
  cat >> $FILE_PATH <<EOM
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

default-storage-engine=innodb
EOM
fi
