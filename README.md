# tpx-monitored-server

## How to use

1. Clone repository:

```bash
$ git clone https://github.com/valmorsecco/tpx-nginx-proxy.git
```

2. Run install.sh:

```bash
$ chmod 777 install.sh
$ ./install.sh
```

## Custom

1. Workdir (default): /srv/www
2. Network (default): nginx-proxy
3. If you want to change it is necessary to edit the file install.sh, nginx-proxy/docker-compose.yml, .tracking/glances/glances.sh

## Credits
- [nginx-proxy](https://github.com/nginx-proxy/nginx-proxy) by [@jwilder](https://github.com/jwilder)
- [docker-gen](https://github.com/jwilder/docker-gen) by [@jwilder](https://github.com/jwilder)
- [docker-letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion) by
 [@JrCs](https://github.com/JrCs)
- [nginx-proxy-automation](https://github.com/evertramos/nginx-proxy-automation) by [@evertramos](https://github.com/evertramos)
