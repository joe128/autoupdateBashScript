# Changelog

## [3.2.0] - 2024-02-08
### Added
 - pull changes for all submodules (recursively)

## [3.1.2] - 2022-01-11
### Fixed
 - Fix check if there were errors during pull of new commits

## [3.1.1] - 2022-01-09
### Fixed
 - abort if there were an error during pull of new commits, to prevent an infinite loop

## [3.1.0] - 2022-01-08
### Added
 - show branch-tip after update
### Fixed
 - using only configured gitBin instead of hard coded ``git``

## [3.0.0] - 2022-01-05
### Added
 - auto-detect of checked out branch
### Deleted
 - AUTOUPDATE_BRANCH

## [2.0.0] - 2021-11-25
### Changed
 - change ``disableAutoUpdate`` to ``.autoUpdateDisable``

### Added
 - add ``.autoUpdateDisableHardReset`` to skip a local git-hard-reset
 - add ``.autoUpdateCheckEveryTime`` to check updates every call
 - add ``[ERR]`` and ``[WARN]`` to log-messages

## [1.0.0] - 2021-11-05
### Added
 - first Release, including
   - AUTOUPDATE_DISABLE
   - AUTOUPDATE_NO_LOCAL_RESET
   - AUTOUPDATE_CHECK_EVERY_TIME
   - AUTOUPDATE_BRANCH
   - AUTOUPDATE_GIT_BIN
