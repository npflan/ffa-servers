#!/bin/bash

export GAMESERVER_TOKEN=$(curl --silent "$TOKEN_API_URL/token/740/$HOSTNAME")
export RCON_PASSWORD="$(< /dev/urandom tr -dc A-Za-z0-9 | head -c32; echo)"

export SERVER_HOSTNAME="${SERVER_HOSTNAME:-}"
export RCON_PASSWORD="${RCON_PASSWORD:-changeme}"
export STEAM_ACCOUNT="${GAMESERVER_TOKEN:-changeme}"
export HL2DM_DIR="${HL2DM_DIR:-/hl2dm}"
export IP="${IP:-0.0.0.0}"
export PORT="${PORT:-27015}"
export TICKRATE="${TICKRATE:-64}"
export MAP="${MAP:-de_dust2}"
export MAXPLAYERS="${MAXPLAYERS:-12}"

: ${HL2DM_DIR:?"ERROR: HL2DM_DIR IS NOT SET!"}

cd $HL2DM_DIR

### Create dynamic server config
cat << SERVERCFG > $HL2DM_DIR/hl2mp/cfg/server.cfg
hostname "$SERVER_HOSTNAME"
rcon_password "$RCON_PASSWORD"
sv_lan 0
sv_cheats 0
SERVERCFG

./srcds_run \
    -console \
    -usercon \
    -game hl2dm \
    -tickrate $TICKRATE \
    -port $PORT \
    -maxplayers_override $MAXPLAYERS \
    +map $MAP \
    +ip $IP \
    +sv_setsteamaccount $STEAM_ACCOUNT
