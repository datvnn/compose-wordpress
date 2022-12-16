
## Docker compose: Wordpress - Php7.4-apache - ioncube - Redis

**Note:** 
- If you are not using `Nginx-proxy-manager`, enable the ports in the `docker-compose.yml` file.

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
git clone 
cd example.com

cp example.env .env
```
Edit file `.env`

Run:
`docker compose up -d`

Options: Existing wp site migration
- upload file database.sql to /opt
- Import data: `docker compose exec -T db mysql -u<WORDPRESS_DB_USER> -p<WORDPRESS_DB_PASSWORD> <WORDPRESS_DB_NAME> < /opt/sql`
- Copy the old `wp-content` folder contents to `wp-data/wp-content/`