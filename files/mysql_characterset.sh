if [ "$sunzi_pkg" = 'apt-get' ]; then
    FILE_PATH = '/etc/mysql/conf.d/mysql_characterset.cnf'
#elif [ "$sunzi_pkg" = 'yum' ]; then
#    FILE_PATH = '/etc/mysql/mysql_characterset.cnf'
else
    exit;
fi

if [-f $FILE_PATH ]; then
  echo 'MySQL character set already set up'
else
  cat >> $FILE_PATH <<EOM
[client]
default-character-set=utf8

[mysql]
default-character-set=utf8

[mysqld]
character-set-server=utf8
EOM
fi
