#!/bin/bash

cd "${0%/*}"
. ../common.sh

echo "Processing CS2..."

ProcessDepot ".so"
ProcessDepot ".dll"
ProcessVPK
ProcessToolAssetInfo
FixUCS2

CreateCommit "$(grep "ClientVersion=" game/csgo/steam.inf | grep -o '[0-9\.]*')" "$1"
