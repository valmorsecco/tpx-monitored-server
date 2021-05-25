#!/bin/bash
###
# install.glances.sh
# Author: Valmor Secco
# Company: Three Pixels Sistemas
# Description: Basic shellscript to install nginx-proxy.
###
BASE_WORKSPACE=/srv/www
BASE_FOLDER=$(pwd)

BASE_NGINX_PROXY_OLD_FOLDER=$BASE_FOLDER/nginx-proxy
BASE_NGINX_PROXY_NEW_FOLDER=$BASE_WORKSPACE/nginx-proxy

###
# nginx_proxy_install
###
nginx_proxy_install() {
  # Try move nginx-proxy
  echo "=> Try move nginx-proxy..."
  if mv $BASE_NGINX_PROXY_OLD_FOLDER $BASE_NGINX_PROXY_NEW_FOLDER; then
    echo "=> Try move nginx-proxy (OK)."
  else
    echo "=> Try move nginx-proxy (FAIL)."
    exit 1
  fi

  # Try create nginx-proxy
  echo "=> Try create nginx-proxy..."
  if docker network create nginx-proxy; then
    echo "=> Try create nginx-proxy (OK)."
  else
    echo "=> Try create nginx-proxy (FAIL)."
  fi
}

###
# nginx_proxy_start
###
nginx_proxy_start() {
  # Try start nginx-proxy
  echo "=> Try start nginx-proxy..."
  if docker-compose -f $BASE_NGINX_PROXY_NEW_FOLDER/docker-compose.yml up -d; then
    echo "=> Try start nginx-proxy (OK)."
  else
    echo "=> Try start nginx-proxy (FAIL)."
  fi
}

###
# fn_install
###
fn_install() {
  echo "### => Installing nginx-proxy... ###"
  if nginx_proxy_install &&
     nginx_proxy_start; then
    echo "### => Installing nginx-proxy (OK). ###"
  else
    echo "### => Installing nginx-proxy (FAIL). ###"
    exit 1
  fi
}

fn_install