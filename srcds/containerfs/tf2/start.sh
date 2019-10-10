#!/bin/bash
/steamcmd/steamcmd.sh +login anonymous +force_install_dir /tf2 +app_update 232250 validate +quit
mkdir /root/.steam/sdk32
ln -s /steamcmd/linux32/steamclient.so /root/.steam/sdk32/steamclient.so


export GAMESERVER_TOKEN=$(curl --silent "$TOKEN_API_URL/token/232250/$HOSTNAME")
export RCON_PASSWORD="$(< /dev/urandom tr -dc A-Za-z0-9 | head -c32; echo)"

export SERVER_HOSTNAME="${SERVER_HOSTNAME:-}"
export RCON_PASSWORD="${RCON_PASSWORD:-changeme}"
export STEAM_ACCOUNT="${GAMESERVER_TOKEN:-changeme}"
export TF2_DIR="${TF2_DIR:-/tf2}"
export IP="${IP:-0.0.0.0}"
export PORT="${PORT:-27015}"
export TICKRATE="${TICKRATE:-64}"
export MAP="${MAP:-ph_lumberyard_a2}"
export MAXPLAYERS="${MAXPLAYERS:-12}"

: ${TF2_DIR:?"ERROR: TF2_DIR IS NOT SET!"}

cd $HL2DM_DIR

### Create dynamic server config
cat << SERVERCFG > $TF2_DIR/tf/cfg/server.cfg
hostname "$SERVER_HOSTNAME"
rcon_password "$RCON_PASSWORD"
sv_lan 0
sv_cheats 0
mp_roundlimit 8
mp_timelimit 20
sv_allowupload 1
sv_allowdownload 1
net_maxfilesize 9999999
sv_downloadurl "$SV_DOWNLOADURL"


SERVERCFG

/tf2/srcds_run \
    -console \
    -usercon \
    -game tf \
    -tickrate $TICKRATE \
    -port $PORT \
    -maxplayers_override $MAXPLAYERS \
    +map $MAP \
    +ip $IP \
    +sv_setsteamaccount $STEAM_ACCOUNT
