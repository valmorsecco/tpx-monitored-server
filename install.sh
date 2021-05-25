#!/bin/bash
###
# basic.sh
# Author: Valmor Secco
# Company: Three Pixels Sistemas
# Description: Basic shellscript to create a monitored server.
###
BASE_WORKSPACE=/srv/www
BASE_NGINX_PROXY_FOLDER=.
BASE_NGINX_PROXY_OLD_FOLDER=$BASE_NGINX_PROXY_FOLDER/nginx-proxy
BASE_NGINX_PROXY_NEW_FOLDER=$BASE_WORKSPACE/nginx-proxy

BASE_TRACKING_OLD_FOLDER=$BASE_NGINX_PROXY_FOLDER/.tracking
BASE_TRACKING_NEW_FOLDER=$BASE_WORKSPACE/.tracking
GLANCES_SH=$BASE_TRACKING_NEW_FOLDER/glances/glances.sh
CLIENT_WS=$BASE_TRACKING_NEW_FOLDER/client-ws

###
# workspace_create
###
workspace_create() {
  # Try initializing folder
  echo "=> Try initializing folder..."
  if sudo mkdir -p $BASE_WORKSPACE; then
    echo "=> Try initializing folder (OK)."
  else
    echo "=> Try initializing folder (FAIL)."
    exit 1
  fi

  # Try move nginx-proxy
  echo "=> Try move nginx-proxy..."
  if mv $BASE_NGINX_PROXY_OLD_FOLDER $BASE_NGINX_PROXY_NEW_FOLDER; then
    echo "=> Try move nginx-proxy (OK)."
  else
    echo "=> Try move nginx-proxy (FAIL)."
    exit 1
  fi
}

###
# workspace_tracking_create
###
workspace_tracking_create() {
  # Try move .tracking
  echo "=> Try move .tracking..."
  if mv $BASE_TRACKING_OLD_FOLDER $BASE_TRACKING_NEW_FOLDER; then
    echo "=> Try move .tracking (OK)."
  else
    echo "=> Try move .tracking (FAIL)."
    exit 1
  fi

  # Try add permission execute to glances.sh
  echo "=> Try add permission execute to glances.sh..."
  if sudo chmod 777 $GLANCES_SH $CLIENT_WS; then
    echo "=> Try add permission execute to glances.sh (OK)."
  else
    echo "=> Try add permission execute to glances.sh (FAIL)."
    exit 1
  fi

  # Try add to crontab
  echo "=> Try add to crontab..."
  if (crontab -l ; echo "* * * * * $GLANCES_SH &> /dev/null") | crontab -; then
    echo "=> Try add to crontab (OK)."
  else
    echo "=> Try add to crontab (FAIL)."
    exit 1
  fi
}

###
# workspace_create_clean
###
workspace_create_clean() {
  # Try remove aux
  echo "=> Try remove aux..."
  if sudo rm -rf $BASE_NGINX_PROXY_FILE $BASE_NGINX_PROXY_FOLDER; then
    echo "=> Try remove aux (OK)."
  else
    echo "=> Try remove aux (FAIL)."
    exit 1
  fi
}


###
# docker_enable
###
docker_enable() {
  # Try enable docker
  echo "=> Try enable docker..."
  if sudo systemctl enable docker; then
    echo "=> Try enable docker (OK)."
  else
    echo "=> Try enable docker (FAIL)."
    exit 1
  fi
}

###
# docker_install
###
docker_install() {
  # Try remove docker
  echo "=> Try remove docker..."
  if sudo yum remove -q -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine; then
    echo "=> Try remove docker (OK)."
  else
    echo "=> Try remove docker (FAIL)."
    exit 1
  fi

  # Try install yum-utils
  echo "=> Try install yum-utils..."
  if sudo yum install -q -y yum-utils; then
    echo "=> Try install yum-utils (OK)."
  else
    echo "=> Try install yum-utils (FAIL)."
    exit 1
  fi

  # Try add repository
  echo "=> Try add repository..."
  if sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo; then
    echo "=> Try add repository (OK)."
  else
    echo "=> Try add repository (FAIL)."
    exit 1
  fi

  # Try install docker-ce, docker-ce-cli, containerd.io
  echo "=> Try install docker-ce, docker-ce-cli, containerd.io..."
  if sudo yum install -q -y docker-ce docker-ce-cli containerd.io; then
    echo "=> Try install docker-ce, docker-ce-cli, containerd.io (OK)."
  else
    echo "=> Try install docker-ce, docker-ce-cli, containerd.io (FAIL)."
    exit 1
  fi

  # Try install docker-compose
  echo "=> Try install docker-compose..."
  if sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose; then
    echo "=> Try install docker-compose (OK)."
  else
    echo "=> Try install docker-compose (FAIL)."
    exit 1
  fi

  # Try permissions docker-compose
  echo "=> Try permissions docker-compose..."
  if sudo chmod +x /usr/local/bin/docker-compose; then
    echo "=> Try permissions docker-compose (OK)."
  else
    echo "=> Try permissions docker-compose (FAIL)."
    exit 1
  fi
}

###
# docker_start
###
docker_start() {
  # Try start docker
  echo "=> Try start docker..."
  if sudo systemctl start docker; then
    echo "=> Try start docker (OK)."
  else
    echo "=> Try start docker (FAIL)."
    exit 1
  fi
}

###
# glances_install
###
glances_install() {
  # Try install epel-release
  echo "=> Try install epel-release..."
  if sudo yum install -y epel-release; then
    echo "=> Try install epel-release (OK)."
  else
    echo "=> Try install epel-release (FAIL)."
    exit 1
  fi

  # Try install python-pip
  echo "=> Try install python-pip..."
  if sudo yum install -y python-pip python-devel; then
    echo "=> Try install python-pip (OK)."
  else
    echo "=> Try install python-pip (FAIL)."
    exit 1
  fi

  # Try install glances
  echo "=> Try install glances..."
  if sudo pip install glances; then
    echo "=> Try install glances (OK)."
  else
    echo "=> Try install glances (FAIL)."
    exit 1
  fi
}

###
# nginx_proxy_start
###
nginx_proxy_start() {
  # Try create nginx-proxy
  echo "=> Try create nginx-proxy..."
  if docker network create nginx-proxy; then
    echo "=> Try create nginx-proxy (OK)."
  else
    echo "=> Try create nginx-proxy (FAIL)."
  fi

  # Try start nginx-proxy
  echo "=> Try start nginx-proxy..."
  if docker-compose -f $BASE_NGINX_PROXY_NEW_FOLDER/docker-compose.yml up -d; then
    echo "=> Try start nginx-proxy (OK)."
  else
    echo "=> Try start nginx-proxy (FAIL)."
  fi
}

###
# fn_uninstall
###
fn_install() {
  echo "=> Installing..."
  if docker_install &&
     docker_start &&
     docker_enable &&
     glances_install &&
     workspace_create &&
     workspace_tracking_create &&
     workspace_create_clean &&
     nginx_proxy_start; then
    echo "=> Installing (OK)."
  else
    echo "=> Installing (FAIL)."
    exit 1
  fi
}

fn_install
