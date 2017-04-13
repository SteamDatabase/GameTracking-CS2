#!/bin/bash

cd "${0%/*}"
. ../common.sh

echo "Processing CS:GO..."

ProcessDepot ".so"
ProcessVPK

mono ../.support/SourceDecompiler/Decompiler.exe -i "csgo/pak01_dir.vpk" -o "csgo/pak01_dir/"

FixUCS2

CreateCommit "$(grep "ClientVersion=" csgo/steam.inf | grep -o '[0-9\.]*') | $(grep "PatchVersion=" csgo/steam.inf | grep -o '[0-9\.]*')"
