#!/bin/bash
###
# install.docker.sh
# Author: Valmor Secco
# Company: Three Pixels Sistemas
# Description: Basic shellscript to install docker and docker-compose.
###

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
# fn_install
###
fn_install() {
  echo "### => Installing docker... ###"
  if docker_install &&
     docker_start &&
     docker_enable; then
    echo "### => Installing docker (OK). ###"
  else
    echo "### => Installing docker (FAIL). ###"
    exit 1
  fi
}

fn_install