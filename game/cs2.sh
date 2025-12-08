#!/bin/bash

# figure out the absolute path to the script being run a bit
# non-obvious, the ${0%/*} pulls the path out of $0, cd's into the
# specified directory, then uses $PWD to figure out where that
# directory lives - and all this in a subshell, so we don't affect
# $PWD

GAMEROOT=$(cd "${0%/*}" && echo $PWD)
SCRIPTNAME=$(basename $0)

[[ "$*" == *"-dedicated"* ]] && DEDICATED_SERVER=1 || DEDICATED_SERVER=0

#determine platform
UNAMEPATH=`command -v uname`
if [ -z $UNAMEPATH ]; then
	if [ -f /usr/bin/uname ]; then
		UNAMEPATH=/usr/bin/uname
	elif [ -f /bin/uname ]; then
		UNAMEPATH=/bin/uname
	fi
fi
UNAME=`${UNAMEPATH}`
if [ "$UNAME" == "Darwin" ]; then
   # Workaround OS X El Capitan 10.11 System Integrity Protection (SIP) which does not allow
   # DYLD_INSERT_LIBRARIES to be set for system processes.
   if [ "$STEAM_DYLD_INSERT_LIBRARIES" != "" ] && [ "$DYLD_INSERT_LIBRARIES" == "" ]; then
      export DYLD_INSERT_LIBRARIES="$STEAM_DYLD_INSERT_LIBRARIES"
   fi
   # prepend our lib path to LD_LIBRARY_PATH
   export DYLD_LIBRARY_PATH="${GAMEROOT}"/bin/osx64:$DYLD_LIBRARY_PATH
elif [ "$UNAME" == "Linux" ]; then
    # CS2 client requires the sniper container runtime
    # We only enforce this for the client, the dedicated server has fewer dependencies and is meant to run on any reasonably up to date glibc distribution.
    . /etc/os-release
    if [ "$DEDICATED_SERVER" == "0" ] && [ "$VERSION_CODENAME" != "sniper" ]; then
        # a dialog box (zenity?) would be nice, but at this point we do not really know what is available to us
        echo
        echo "FATAL: It appears $SCRIPTNAME was not launched within the Steam for Linux sniper runtime environment."
        echo "FATAL: Please consult documentation to ensure correct configuration, aborting."
        echo
        exit 1
    fi

   # prepend our lib path to LD_LIBRARY_PATH
   export LD_LIBRARY_PATH="${GAMEROOT}"/bin/linuxsteamrt64:$LD_LIBRARY_PATH
   USE_STEAM_RUNTIME=1
fi

if [ -z $GAMEEXE ]; then
   if [ "$UNAME" == "Darwin" ]; then
      GAMEEXE=bin/osx64/cs2.app/Contents/MacOS/cs2
   elif [ "$UNAME" == "Linux" ]; then
      GAMEEXE=bin/linuxsteamrt64/cs2
   fi
fi

ulimit -n 65535

# Set default thread size.
ulimit -Ss 1024

# and launch the game
cd "$GAMEROOT"

# Enable path match if we are running with loose files
if [ "$UNAME" == "Linux" ]; then
	export ENABLE_PATHMATCH=1
fi

# There is Wayland support in SDL but a recent (7/30/2025) attempt at
# allowing SDL to default to Wayland caused a number of customer issues so
# keep the default at X11 for now. Don't override any user setting so
# people can easily use Wayland if they want.
if [ "$UNAME" == "Linux" ]; then
	if [ -z "$SDL_VIDEO_DRIVER" ]; then
		export SDL_VIDEO_DRIVER=x11
	fi
fi


# Do the following for strace:
# 	GAME_DEBUGGER="strace -f -o strace.log"

STATUS=42
while [ $STATUS -eq 42 ]; do
	if [ "${GAME_DEBUGGER}" == "gdb" ] || [ "${GAME_DEBUGGER}" == "cgdb" ]; then
		ARGSFILE=$(mktemp $USER.cs2.gdb.XXXX)
		echo b main > "$ARGSFILE"

		# Set the LD_PRELOAD varname in the debugger, and unset the global version. This makes it so that
		#   gameoverlayrenderer.so and the other preload objects aren't loaded in our debugger's process.
		echo set env LD_PRELOAD=$LD_PRELOAD >> "$ARGSFILE"
		echo show env LD_PRELOAD >> "$ARGSFILE"
		# Unless you are chasing a bug that is explicitly related to address space randomization..
		#echo set disable-randomization off >> "$ARGSFILE"
		unset LD_PRELOAD

		echo run $@ >> "$ARGSFILE"
		echo show args >> "$ARGSFILE"
		${GAME_DEBUGGER} "${GAMEROOT}"/${GAMEEXE} -x "$ARGSFILE"
		rm "$ARGSFILE"
	elif [ "${GAME_DEBUGGER}" == "lldb" ]; then
		${GAME_DEBUGGER} "${GAMEROOT}"/${GAMEEXE} -- $@
	else
		${STEAM_RUNTIME_PREFIX} ${GAME_DEBUGGER} "${GAMEROOT}"/${GAMEEXE} "$@"
	fi
	STATUS=$?
done
exit $STATUS
