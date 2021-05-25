#!/bin/bash
###
# basic.sh
# Author: Valmor Secco
# Company: Three Pixels Sistemas
# Description: Basic shellscript to create a monitored server.
###
BASE_WORKSPACE=/srv/www
BASE_FOLDER=$(pwd)

BASE_INSTALL_DOCKER_SH=$BASE_FOLDER/install/install.docker.sh
BASE_INSTALL_GLANCES_SH=$BASE_FOLDER/install/install.glances.sh
BASE_INSTALL_NGINX_SH=$BASE_FOLDER/install/install.nginx.sh

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
}

###
# workspace_create_clean
###
workspace_create_clean() {
  # Try remove aux
  echo "=> Try remove aux..."
  if sudo rm -rf $BASE_FOLDER; then
    echo "=> Try remove aux (OK)."
  else
    echo "=> Try remove aux (FAIL)."
    exit 1
  fi
}

###
# fn_install_full
###
fn_install_full() {
  echo "=> Installing full..."
  if workspace_create &&
     fn_install_docker &&
     fn_install_glances &&
     fn_install_nginx &&
     workspace_create_clean; then
    echo "=> Installing full (OK)."
  else
    echo "=> Installing full (FAIL)."
    exit 1
  fi
}

###
# fn_install_docker
###
fn_install_docker() {
  # Try add permission execute to install.docker.sh
  echo "=> Try add permission execute to install.docker.sh..."
  if sudo chmod 777 $BASE_INSTALL_DOCKER_SH; then
    echo "=> Try add permission execute to install.docker.sh (OK)."
  else
    echo "=> Try add permission execute to install.docker.sh (FAIL)."
    exit 1
  fi

  echo "=> Installing docker..."
  if $BASE_INSTALL_DOCKER_SH; then
    echo "=> Installing docker (OK)."
  else
    echo "=> Installing docker (FAIL)."
    exit 1
  fi
}

###
# fn_install_glances
###
fn_install_glances() {
  # Try add permission execute to install.glances.sh
  echo "=> Try add permission execute to install.glances.sh..."
  if sudo chmod 777 $BASE_INSTALL_GLANCES_SH; then
    echo "=> Try add permission execute to install.glances.sh (OK)."
  else
    echo "=> Try add permission execute to install.glances.sh (FAIL)."
    exit 1
  fi

  echo "=> Installing glances..."
  if $BASE_INSTALL_GLANCES_SH; then
    echo "=> Installing glances (OK)."
  else
    echo "=> Installing glances (FAIL)."
    exit 1
  fi
}

###
# fn_install_nginx
###
fn_install_nginx() {
  # Try add permission execute to install.nginx.sh
  echo "=> Try add permission execute to install.nginx.sh..."
  if sudo chmod 777 $BASE_INSTALL_NGINX_SH; then
    echo "=> Try add permission execute to install.nginx.sh (OK)."
  else
    echo "=> Try add permission execute to install.nginx.sh (FAIL)."
    exit 1
  fi

  echo "=> Installing nginx..."
  if $BASE_INSTALL_NGINX_SH; then
    echo "=> Installing nginx (OK)."
  else
    echo "=> Installing nginx (FAIL)."
    exit 1
  fi
}

case "$1" in
full)
    fn_install_full
;;
docker)
    fn_install_docker
;;
glances)
    fn_install_glances
;;
nginx)
    fn_install_nginx
;;
*)
;;
esac

exit 0
