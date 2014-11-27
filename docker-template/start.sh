WORDPRESS_DB="wordpress"
MYSQL_PASSWORD=""
WORDPRESS_PASSWORD=""

/etc/init.d/mysqld start

mysqladmin -u root password "$MYSQL_PASSWORD"

mysql --user="root" --password="$MYSQL_PASSWORD" \
    -e "CREATE DATABASE IF NOT EXISTS wordpress;" \
    -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY '$WORDPRESS_PASSWORD';" \
    -e "FLUSH PRIVILEGES;"