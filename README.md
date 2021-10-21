# autoupdateBashScript
template to auto-update bash-scripts

## configuration
 * set AUTOUPDATE_DISABLE or add file ``disableAutoUpdate`` to disable auto-update
 * set AUTOUPDATE_NO_LOCAL_RESET to skip a local git-hard-reset
 * set AUTOUPDATE_CHECK_EVERY_TIME to check updates every call (default once per day)
 * set AUTOUPDATE_BRANCHE to use a differnt branche (default: main)
 * set AUTOUPDATE_GIT_BIN if there is a problem detecting git-binary