
DRYRUN=1
SNAPSHOT_ROOT=/data/backup/test
VERBOSITY=4

SOURCES="
snapshot /data/backup/test/source snapped-source
local /data/backup/test/source2 synced-source
ssh caladan:~/code/./ arrakis-code
"
