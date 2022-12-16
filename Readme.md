
## Docker compose: Wordpress - Php7.4-apache - ioncube - Mariadb -Redis

**Note:** 
- If you are not using `Nginx-proxy-manager`, enable the ports in the `docker-compose.yml` file.
- If you want to use php8.1 and ioncube, check if the plugin supports iconcube on php8.1. Plugin runs with ioncube php7.4 but not sure to run with ioncube php8.1

**services:**
 - Wordpress: php7.4-apache
 - db: Mariadb
 - redis

 PHP php extension:
  - ioncube
  - phpredis

**Install:**
```
cd /opt
git clone https://github.com/datvnn/compose-wordpress-apache.git example.com
cd example.com

cp example.env .env
```
Edit file `.env`

Run: `docker compose up -d`

Done: Visit example.com

Options: Existing wp site migration
- upload file database.sql to /opt
- Import data: `docker compose exec -T db mysql -u<WORDPRESS_DB_USER> -p<WORDPRESS_DB_PASSWORD> <WORDPRESS_DB_NAME> < /opt/sql`
- Copy the old `wp-content` folder contents to `wp-data/wp-content/`

Connect Redis
- install Plugin `Redis Object Cache`
- Enable Object Cache

Check redis-cli
```
docker compose exec redis bash
redis-cli
keys *
```