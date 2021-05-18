# tpx-nginx-proxy

## How to use

1. Clone repository:

```bash
$ git clone https://github.com/valmorsecco/tpx-nginx-proxy.git
```

2. Create network:

```bash
$ cd nginx-proxy
$ docker network create nginx-proxy
```

3. Run docker-compose:

```bash
$ docker-compose up -d
```

## Custom

1. Workdir (default): /srv/www/nginx-proxy
2. Network (default): nginx-proxy
3. If you want to change it is necessary to edit the file nginx-proxy/docker-compose.yml

## Credits
- [nginx-proxy](https://github.com/nginx-proxy/nginx-proxy) by [@jwilder](https://github.com/jwilder)
- [docker-gen](https://github.com/jwilder/docker-gen) by [@jwilder](https://github.com/jwilder)
- [docker-letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion) by
 [@JrCs](https://github.com/JrCs)
- [nginx-proxy-automation](https://github.com/evertramos/nginx-proxy-automation) by [@evertramos](https://github.com/evertramos)
