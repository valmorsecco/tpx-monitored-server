# tpx-monitored-server

## How to use (CentOS 7)

1. Clone repository:

```bash
$ git clone https://github.com/valmorsecco/tpx-nginx-proxy.git
```
3. Edit .tracking/client-ws.conf:

* Path to receive .csv files:

```bash
$ CLIENT_WS_DIR=/srv/www/.tracking/glances/data
```

* Socket server URL:
```bash
$ CLIENT_WS_URL=http://ip:port
```

2. Run install.sh:

```bash
$ chmod +x install.sh
$ ./install.sh full
```

## Custom

1. Workdir (default): /srv/www
2. Network (default): nginx-proxy
3. If you want to change it is necessary to edit the file install.sh, nginx-proxy/docker-compose.yml, .tracking/glances/glances.sh

## Credits project
- [tpx-monitored-server](https://github.com/valmorsecco/tpx-monitored-server) by [@valmorsecco](https://github.com/valmorsecco)

## Credits nginx-proxy
- [nginx-proxy](https://github.com/nginx-proxy/nginx-proxy) by [@jwilder](https://github.com/jwilder)
- [docker-gen](https://github.com/jwilder/docker-gen) by [@jwilder](https://github.com/jwilder)
- [docker-letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion) by [@JrCs](https://github.com/JrCs)
- [nginx-proxy-automation](https://github.com/evertramos/nginx-proxy-automation) by [@evertramos](https://github.com/evertramos)

## Credits glances
- [glances](https://github.com/nicolargo/glances) by [@nicolargo](https://github.com/nicolargo)