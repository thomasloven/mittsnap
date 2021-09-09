
DRYRUN=0
BACKUP_ROOT=/data/backup/test
VERBOSITY=4

KEEP_DAILY=7
KEEP_WEEKLY=5
KEEP_MONTHLY=12

RSYNC_ARGUMENTS="--exclude 'node_modules'"

SOURCES="
snapshot /data/backup/test/source snapped-source
local /data/backup/test/source2 synced-source
ssh caladan:~/code/./ arrakis-code
"
