#!/bin/bash
set -euo pipefail

cd "${0%/*}"
. ../common.sh

echo "Processing CS2..."

set +e
../tools/dump_source2.sh csgo CS2
DUMPER_EXIT_CODE=$?
set -e

ProcessDepot ".so"
ProcessDepot ".dll"
ProcessDepot ".exe"
DeduplicateStringsFrom ".so" "game/bin/linuxsteamrt64/libengine2_strings.txt" "game/bin/linuxsteamrt64/libtier0_strings.txt" "DumpSource2/.stringsignore"
DeduplicateStringsFrom ".dll" "game/bin/linuxsteamrt64/libengine2_strings.txt" "game/bin/linuxsteamrt64/libtier0_strings.txt" "DumpSource2/.stringsignore"
DeduplicateStringsFrom ".exe" "game/bin/linuxsteamrt64/libengine2_strings.txt" "game/bin/linuxsteamrt64/libtier0_strings.txt" "DumpSource2/.stringsignore"
ProcessVPK

set +e
while IFS= read -r -d '' file
do
	echo " > $file"

	# When updating vpk_extensions, also update "vpk:..." in GameTracking/files.json
	"$VRF_PATH" \
		--input "$file" \
		--output "$(echo "$file" | sed -e 's/\.vpk$/\//g')" \
		--vpk_cache \
		--vpk_decompile \
		--vpk_extensions "txt,lua,kv3,db,gameevents,vcss_c,vjs_c,vts_c,vxml_c,vsndevts_c,vsndstck_c,vpulse_c,vdata_c"
	if [[ "$DUMPER_EXIT_CODE" -eq 0 ]] && [[ $? -ne 0 ]]; then
		DUMPER_EXIT_CODE=$?
	fi
done <   <(find . -type f -name "pak01_dir.vpk" -print0)
set -e

while IFS= read -r -d '' file
do
	sed -i '/\/\/# sourceMappingURL=/d' "$file"
done <   <(find . -type f -name "*.js" -print0)

ProcessToolAssetInfo

FixUCS2

CreateCommit "$(grep "ClientVersion=" game/csgo/steam.inf | grep -o '[0-9\.]*')" "${1:-}"

echo "Done"

exit "$DUMPER_EXIT_CODE"
