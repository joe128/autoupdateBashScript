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
        echo "[WARN][autoUpdate] Git not found, define env-var 'AUTOUPDATE_GIT_BIN' to use autoupdate."
        gitbin=""
    fi
fi

# run auto-update daily, not if file disableAutoUpdate exists or env AUTOUPDATE_DISABLE is set
if [ -n "${gitbin}" ] && [ ! -f "$(dirname "$0")/.autoUpdateDisable" ] && [ -z "$AUTOUPDATE_DISABLE" ] && [ -d "$(dirname "$0")/.git" ]; then
    [ -z "${AUTOUPDATE_NO_LOCAL_RESET}" ] && [ ! -f "$(dirname "$0")/.autoUpdateDisableHardReset" ] && doHardReset=1 || doHardReset=0
    scriptName=$(basename "$0")
    today=$(date +'%Y-%m-%d')
    autoUpdateStatusFile="/tmp/.${scriptName}-autoUpdate"
    if [ -n "${AUTOUPDATE_CHECK_EVERY_TIME}" ] || [ -f "$(dirname "$0")/.autoUpdateCheckEveryTime" ] || [ ! -f "$autoUpdateStatusFile" ] || [ "${today}" != "$(date -r ${autoUpdateStatusFile} +'%Y-%m-%d')" ]; then
        echo "[autoUpdate] Checking git-updates of ${scriptName}..."
        touch "$autoUpdateStatusFile"
        cd "$(dirname "$0")" || exit 1
        $gitbin fetch
        gitBranch=$(${gitbin} rev-parse --abbrev-ref HEAD)
        gitBranch=${gitBranch:=main}
        origin=$(git for-each-ref --format='%(upstream:short)' "$(git symbolic-ref -q HEAD)")
        [ -n "$origin" ] && commits=$(git rev-list HEAD...origin/"$gitBranch" --count) || commits=0
        if [ $commits -gt 0 ]; then
            echo "[autoUpdate] Found updates ($commits commits)..."
            [ $doHardReset -gt 0 ] && $gitbin reset --hard
            $gitbin pull --force
            echo "[autoUpdate] Executing new version..."
            exec "$(pwd -P)/${scriptName}" "$@"
            # In case executing new fails
            echo "[ERR][autoUpdate] Executing new version failed."
            exit 1
        fi
        echo "[autoUpdate] No updates available."
    else
        echo "[autoUpdate] Already checked for updates today."
    fi
fi