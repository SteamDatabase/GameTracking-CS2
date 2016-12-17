#!/bin/bash

cd "${0%/*}"
. ../common.sh

echo "Processing CS:GO..."

ProcessDepot ".so"
ProcessVPK

mono ../.support/SourceDecompiler/Decompiler.exe -i "csgo/pak01_dir.vpk" -o "csgo/pak01_dir/"

echo "Fixing UCS-2"

while IFS= read -r -d '' file
do
	if ! file --mime "$file" | grep "charset=utf-16le"
	then
		continue
	fi

	temp_file=$(mktemp)
	iconv -t UTF-8 -f UCS-2 -o "$temp_file" "$file" &&
	mv -f "$temp_file" "$file"
done <   <(find csgo/ -name "*.txt" -type f -print0)

CreateCommit "$(grep "ClientVersion=" csgo/steam.inf | grep -o '[0-9\.]*') | $(grep "PatchVersion=" csgo/steam.inf | grep -o '[0-9\.]*')"
