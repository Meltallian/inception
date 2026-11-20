# Inception

A small web infrastructure built from scratch with Docker Compose: **NGINX → WordPress (PHP-FPM) → MariaDB**, each in its own container, all built from hand-written Dockerfiles on `debian:11`. No pre-built service images.

42 School system-administration project.

## Architecture

```
          :443 (TLS 1.3 only)
 client ─────────────► nginx ──fastcgi :9000──► wordpress (php-fpm 7.4)
                         │                           │
                         │                           │ :3306
                         ▼                           ▼
                 [volume: wordpress]             mariadb ──► [volume: mariadb]

            all three containers on the private bridge network "inception"
```

| Service | What it does |
|---|---|
| **nginx** | The only entry point (port 443). Generates a self-signed certificate at startup with `openssl`, serves TLS 1.3 only, and forwards `.php` requests to PHP-FPM over FastCGI. |
| **wordpress** | Installs WordPress and the WP-CLI tool on first run, writes `wp-config.php` from environment variables, creates the admin user and an author user, then runs `php-fpm` in the foreground on port 9000. |
| **mariadb** | Initializes the data directory on first boot only: creates the database and app user, sets the root password, then `exec`s `mysqld` as PID 1. Not exposed to the host. |

Design points:
- **One process per container, running in the foreground** (`nginx -g "daemon off;"`, `php-fpm -F`, `exec mysqld`). No `tail -f` or `sleep infinity` hacks.
- **Persistent bind-mounted volumes** for the WordPress files and the database, so data survives `docker compose down`.
- **Configuration through environment variables**: all credentials and site settings are read from `srcs/.env`.
- `restart: always` on every service.

## Running it

Requirements: Docker with the Compose plugin, and `make`.

1. Create the volume directories on the host (paths are set in `srcs/docker-compose.yml`, adjust them to your machine):
   ```bash
   mkdir -p ~/wordpress ~/mariadb
   ```
2. Create `srcs/.env`:
   ```dotenv
   DOMAIN_NAME=login.42.fr
   CERTS_=/etc/ssl/certs/nginx-selfsigned.crt

   DB_NAME=wordpress
   DB_USER=wpuser
   DB_PWD=change-me
   DB_ROOT_PWD=change-me-too

   WP_TITLE=Inception
   WP_ADMIN_USR=boss
   WP_ADMIN_PWD=change-me
   WP_ADMIN_EMAIL=boss@example.com
   WP_USR=author
   WP_EMAIL=author@example.com
   WP_PWD=change-me
   ```
3. Point the domain to your machine (`127.0.0.1 login.42.fr` in `/etc/hosts`), then:
   ```bash
   make build   # build the three images, no cache
   make up      # start the stack
   ```
4. Open `https://login.42.fr`. Your browser will warn about the self-signed certificate, which is expected.

Other targets: `make down`, `make stop`, `make logs`, `make cleanup` (prune unused Docker resources), `make volume-killer` (prune volumes).

## What I learned

- How a request actually travels through a classic LEMP stack: TLS termination, FastCGI, and the PHP-to-database connection.
- Writing container entrypoints correctly: PID 1, foreground processes, and why one-time initialization must be separate from the long-running process.
- Docker networking (service-name DNS on a user-defined bridge) and volumes (named volumes backed by host bind mounts).
