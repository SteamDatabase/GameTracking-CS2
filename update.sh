#!/bin/bash

cd "${0%/*}"
. ../common.sh

echo "Processing CS:GO..."

ProcessDepot ".so"
ProcessVPK

mono ../.support/SourceDecompiler/Decompiler.exe -i "csgo/pak01_dir.vpk" -o "csgo/pak01_dir/"

#iconv -t UTF-8 -f UCS-2 -o "csgo/csgo/resource/csgo_english_utf8.txt" "csgo/csgo/resource/csgo_english.txt"

if ! [[ $1 = "no-git" ]]; then
	CreateCommit "$(grep "PatchVersion=" csgo/steam.inf | grep -o '[0-9\.]*')"
fi
