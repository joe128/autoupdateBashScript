#!/bin/bash

# get installed git
gitbin="$AUTOUPDATE_GIT_BIN"
if [ -z $gitbin ]; then
    if command -v /usr/bin/git > /dev/null; then
        gitbin="/usr/bin/git"
    elif command -v /usr/local/git/bin/git > /dev/null; then
        gitbin="/usr/local/git/bin/git"
    elif command -v /opt/bin/git > /dev/null; then
        gitbin="/opt/bin/git"
    else
        echo "[autoUpdate] Git not found, define env-var 'AUTOUPDATE_GIT_BIN' to use autoupdate."
        gitbin=""
    fi
fi

# run auto-update daily, not if file disableAutoUpdate exists or env AUTOUPDATE_DISABLE is set
if [ ! -z "${gitbin}" ] && [ ! -f "$(dirname "$0")/disableAutoUpdate" ] && [ -z "$AUTOUPDATE_DISABLE" ] && [ -d "$(dirname "$0")/.git" ]; then
    gitBranch=${AUTOUPDATE_BRANCH:=main}
    scriptName=$(basename "$0")
    today=$(date +'%Y-%m-%d')
    autoUpdateStatusFile="/tmp/.${scriptName}-autoUpdate"
    if [ -n "${AUTOUPDATE_CHECK_EVERY_TIME}" ] || [ ! -f "$autoUpdateStatusFile" ] || [ "${today}" != "$(date -r ${autoUpdateStatusFile} +'%Y-%m-%d')" ]; then
        echo "[autoUpdate] Checking git-updates of ${scriptName}..."
        touch "$autoUpdateStatusFile"
        cd "$(dirname "$0")" || exit 1
        $gitbin fetch
        commits=$(git rev-list HEAD...origin/"$gitBranch" --count)
        if [ $commits -gt 0 ]; then
            echo "[autoUpdate] Found updates ($commits commits)..."
            [ -z "${AUTOUPDATE_NO_LOCAL_RESET}" ] && $gitbin reset --hard 
            $gitbin pull --force
            echo "[autoUpdate] Executing new version..."
            exec "$(pwd -P)/${scriptName}" "$@"
            # In case executing new fails
            echo "[autoUpdate] Executing new version failed."
            exit 1
        fi
        echo "[autoUpdate] No updates available."
    else
        echo "[autoUpdate] Already checked for updates today."
    fi
fi