#!/bin/bash

/steamcmd/steamcmd.sh +login anonymous +force_install_dir /hl2dm +app_update 232370 validate +quit

export GAMESERVER_TOKEN=$(curl --silent "$TOKEN_API_URL/token/232370/$HOSTNAME")
export RCON_PASSWORD="$(< /dev/urandom tr -dc A-Za-z0-9 | head -c32; echo)"

export SERVER_HOSTNAME="${SERVER_HOSTNAME:-}"
export RCON_PASSWORD="${RCON_PASSWORD:-changeme}"
export STEAM_ACCOUNT="${GAMESERVER_TOKEN:-changeme}"
export HL2DM_DIR="${HL2DM_DIR:-/hl2dm}"
export IP="${IP:-0.0.0.0}"
export PORT="${PORT:-27015}"
export TICKRATE="${TICKRATE:-64}"
export MAP="${MAP:-dm_box_bs_final}"
export MAXPLAYERS="${MAXPLAYERS:-12}"
export GRAVITY="$GRAVITY:-800}"

: ${HL2DM_DIR:?"ERROR: HL2DM_DIR IS NOT SET!"}

cd $HL2DM_DIR

### Create dynamic server config
cat << SERVERCFG > $HL2DM_DIR/hl2mp/cfg/server.cfg
hostname "$SERVER_HOSTNAME"
rcon_password "$RCON_PASSWORD"
sv_gravity "$GRAVITY"
sv_lan 0
sv_cheats 0
mp_roundlimit 8
mp_timelimit 20
sv_allowupload 1
sv_allowdownload 1
net_maxfilesize 9999999
sv_downloadurl "$SV_DOWNLOADURL"

SERVERCFG

./srcds_run \
    -console \
    -usercon \
    -game hl2mp \
    -tickrate $TICKRATE \
    -port $PORT \
    -maxplayers $MAXPLAYERS \
    +map $MAP \
    +ip $IP \
    +sv_setsteamaccount $STEAM_ACCOUNT
