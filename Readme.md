
## Docker compose: Wordpress - Php7.4-apache - ioncube - Mariadb -Redis

**Note:** 
- If you are not using `Nginx-proxy-manager`, enable the ports in the `docker-compose.yml` file.
- If you want to use php8.1 and ioncube, check if the plugin supports iconcube on php8.1. Plugin runs with ioncube php7.4 but not sure to run with ioncube php8.1
- The wp-config.php file automatically updates the database information from the environment variables in docker-compose.yml, you don't need to do anything.
- Comment (#) the parts you don't use

**services:**
 - Wordpress: php7.4-apache
 - db: Mariadb
 - redis

 PHP php extension:
  - ioncube
  - phpredis

**Pre-generate docker networks:**
For nginx-proxy-manager
- `docker network create nginx-proxy-man`
For phpmyadmin
- `docker network create pma-external` 


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

**Options: phpmyadmin (multiple database servers)**

/opt/phpmyadmin/docker-compose.yml
```
version: '3.9'

services:
  db:
    image: mariadb:10.6.4-focal
    restart: always
    networks:
      - pma
    environment:
      MYSQL_ROOT_PASSWORD: changeme@pas

  phpmyadmin:
    image: phpmyadmin
    restart: always
    networks:
      - default
      - pma_net
      - pma
    # ports:
      # - 8080:80
    environment:
      - PMA_ARBITRARY=1
networks:
  default:
    external: true
    name: nginx-proxy-man
  pma_net:
    external: true
    name: pma-external
  pma:
    internal: true
```

Login phpmyadmin:
- Server: name container of data wordpress
- user: root
- pass: MYSQL_ROOT_PASSWORD (dataserver wp)