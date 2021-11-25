# autoupdateBashScript
template to auto-update a project over bash-script

## configuration
 * set AUTOUPDATE_DISABLE or add file ``.autoUpdateDisable`` to disable auto-update
 * set AUTOUPDATE_NO_LOCAL_RESET or add file ``.autoUpdateDisableHardReset`` to skip a local git-hard-reset
 * set AUTOUPDATE_CHECK_EVERY_TIME or add file ``.autoUpdateCheckEveryTime`` to check updates every call (default once per day)
 * set AUTOUPDATE_BRANCH to use a different branch (default: main)
 * set AUTOUPDATE_GIT_BIN if there is a problem detecting git-binary