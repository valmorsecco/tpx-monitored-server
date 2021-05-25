#!/bin/bash
###
# install.glances.sh
# Author: Valmor Secco
# Company: Three Pixels Sistemas
# Description: Basic shellscript to install glances.
###
BASE_WORKSPACE=/srv/www
BASE_FOLDER=$(pwd)

BASE_TRACKING_OLD_FOLDER=$BASE_FOLDER/.tracking
BASE_TRACKING_NEW_FOLDER=$BASE_WORKSPACE/.tracking

GLANCES_SH=$BASE_TRACKING_NEW_FOLDER/glances/glances.sh
CLIENT_WS=$BASE_TRACKING_NEW_FOLDER/client-ws

CLIENT_WS_SH_OLD=$BASE_TRACKING_NEW_FOLDER/client-ws.sh
CLIENT_WS_SH_NEW=/etc/init.d/client-ws.sh


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
# glances_start
###
glances_start() {
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
  if sudo chmod 777 $GLANCES_SH $CLIENT_WS $CLIENT_WS_SH_OLD; then
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

  # Try move client-ws.sh
  echo "=> Try move client-ws.sh..."
  if mv $CLIENT_WS_SH_OLD $CLIENT_WS_SH_NEW; then
    echo "=> Try move client-ws.sh (OK)."
  else
    echo "=> Try move client-ws.sh (FAIL)."
    exit 1
  fi
}

###
# fn_install
###
fn_install() {
  echo "### => Installing glances... ###"
  if glances_install &&
     glances_start; then
    echo "### => Installing glances (OK). ###"
  else
    echo "### => Installing glances (FAIL). ###"
    exit 1
  fi
}

fn_install