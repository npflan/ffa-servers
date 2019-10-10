#!/bin/bash

. ../common.sh


if [[ ! `ls mmsource-*-linux.tar.gz` ]]
then

	MMVERSION=$( curl http://www.metamodsource.net/downloads.php | grep -o "mmsource-[0-9\.]*-git[0-9]\+-linux.tar.gz" | head -n 1 )
	MMMAJORVERSION=$(echo $MMVERSION | cut -d '-' -f 2 | cut -d '.' -f 1,2 )

	curl -o $MMVERSION https://mms.alliedmods.net/mmsdrop/$MMMAJORVERSION/$MMVERSION

fi

if [[ ! `ls sourcemod-*-linux.tar.gz` ]]
then
	SMVERSION=$(  curl http://www.sourcemod.net/downloads.php?branch=stable | grep -Eo "sourcemod-.*?-linux.tar.gz" | head -n 1 )

	SMMAJORVERSION=$( echo $SMVERSION | grep -Eo "\-[0-9]*\.[0-9]*" |  grep -Eo "[0-9]*\.[0-9]*")

	echo $SMVERSION
	echo $SMMAJORVERSION

	SMURL="http://www.sourcemod.net/smdrop/$SMMAJORVERSION/$SMVERSION"
	echo "Downloading sourcemod: $SMURL"
	curl -o $SMVERSION $SMURL
fi


[[ -f tf2items.zip ]] || wget -O tf2items.zip https://builds.limetech.io/files/tf2items-1.6.4-hg279-linux.zip || (echo "couldn't download tf2items" && exit 1)

[[ -f prophunt-source.zip ]] || wget -O prophunt-source.zip https://github.com/powerlord/sourcemod-prophunt/releases/download/v3.3.3/prophunt-redux-3.3.3.zip || (echo "couldn't download PropHunt source" && exit 1)

[[ -f sm_observerpoint.smx ]] || curl -o sm_observerpoint.smx "http://www.sourcemod.net/vbcompiler.php?file_id=34433" || (echo "Coudln't download observerpoint" && exit 1)

[[ -f PHMapEssentialsBZ2.7z ]] || curl -L -o PHMapEssentialsBZ2.7z "https://github.com/powerlord/sourcemod-prophunt/releases/download/maps/PHMapEssentialsBZ2.7z" || (echo "Coudln't download prophunt maps" && exit 1)

[[ -f dhooks-2.2.0-hg132-linux.tar.gz ]] || curl -L -o dhooks-2.2.0-hg132-linux.tar.gz "http://users.alliedmods.net/~drifter/builds/dhooks/2.2/dhooks-2.2.0-hg132-linux.tar.gz" || (echo "Coudln't download dHooks" && exit 1)

[[ -f PHDataPack-2015-09-10.zip ]] || curl -L -o PHDataPack-2015-09-10.zip "https://forums.alliedmods.net/attachment.php?attachmentid=148102&d=1441898230" || (echo "Coudln't download PHdataPack" && exit 1)

[[ -f prophunt.smx ]] || curl -L -o prophunt.smx "https://github.com/powerlord/sourcemod-prophunt/releases/download/v3.3.3/prophunt.smx" || (echo "Coudln't download Prophunt.smx" && exit 1)


