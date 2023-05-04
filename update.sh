#!/bin/bash

cd "${0%/*}"
. ../common.sh

echo "Processing CS:GO..."

ProcessDepot ".so"
ProcessDepot ".dll"
ProcessVPK

unzip -lv ./csgo/panorama/code.pbin > ./csgo/panorama/code_pbin.txt

FixUCS2

CreateCommit "$(grep "ClientVersion=" game/csgo/steam.inf | grep -o '[0-9\.]*') (CSGO: $(grep "ClientVersion=" csgo/steam.inf | grep -o '[0-9\.]*'))" "$1"
