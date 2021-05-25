#!/bin/bash
### BEGIN INIT INFO
# Provides:          client-ws.sh
# Required-Start:    $local_fs $remote_fs $network $syslog $named
# Required-Stop:     $local_fs $remote_fs $network $syslog $named
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# X-Interactive:     true
# Short-Description: ClientWS StartUP
# Description:       ClientWS StartUP
#  This script will start the client-ws.
### END INIT INFO

CLIENT_WS_PATH=/srv/www/.tracking
CLIENT_WS_PATH_CONF=$CLIENT_WS_PATH/client-ws.conf
CLIENT_WS_PATH_BIN=$CLIENT_WS_PATH/client-ws

CLIENT_WS_PRC=CLIENT_WS
CLIENT_WS_PID=$(pidof $CLIENT_WS_PRC)

source $CLIENT_WS_PATH_CONF

SYS=0
if [ "$CLIENT_WS_PID" != "" ] ; then
    SYS=1
fi

fn_start() {
    if [ $SYS = 0 ] ; then
        echo "Starting client-ws..."
        SYS=1
        exec -a $CLIENT_WS_PRC $CLIENT_WS_PATH_BIN --url $CLIENT_WS_URL --dir $CLIENT_WS_DIR &> /dev/null &
    fi
}

fn_start_log() {
    if [ $SYS = 0 ] ; then
        echo "Starting client-ws..."
        SYS=1
        exec -a $CLIENT_WS_PRC $CLIENT_WS_PATH_BIN --url $CLIENT_WS_URL --dir $CLIENT_WS_DIR &
    fi
    echo "Started."
}

fn_stop() {
    if [ $SYS = 1 ] ; then
        echo "Stopping client-ws..."
        SYS=0
        kill -9 $CLIENT_WS_PID
    fi
    echo "Stopped."
}

fn_restart() {
   fn_stop && fn_start
}

case "$1" in
start)
    fn_start
;;
start_log)
    fn_start_log
;;
restart)
    fn_restart
;;
stop)
    fn_stop
;;
force_stop)
    fn_force_stop
;;
*)
;;
esac

exit 0