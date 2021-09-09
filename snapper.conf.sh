# Dry run. Must be explicitly set to 0 to perform actual file system operations.
# DRYRUN=0

# Root directory of backup snapshot storage
BACKUP_ROOT=/backup

# Verbosity level determines how much ouput is written to stderr
# 1: Critical errors
# 2: Errors
# 3: Warnings (default)
# 4: Information
# 5: Debug

# VERBOSITY=4

# All performed operations are logged to LOGFILE
# LOGFILE=/var/log/snapper.log

# File used for the PID lock
# LOCKFILE=/var/lock/snapper.pid

# Numbers of each type of backup to retain
# KEEP_DAILY=7
# KEEP_WEEKLY=4
# KEEP_MONTHLY=120

# Additional arguments to RSYNC
# RSYNC_ARGUMENTS=""

# Sources to backup from
# A list of <protocol> <source> <target>
# <protocol>:
#   snapshot - makes a snapshot of a btrfs subvolume
#   local - rsync from local source
#   ssh - rsync over ssh
# <source>: Source subvolume or rsync path
#   note that rsync splits the path at a /./ and only retains what comes after it
# <target>: Location in backup
#   snapshots will be stored to BACKUP_ROOT/daily.0/<target>
#   local and ssh will be stored to BACKUP_ROOT/daily.0/local/<target>
#
# Ex:
# SOURCES="
# snapshot /data/photos photos
# local /home/./thomasloven server/homedir
# ssh thomas@laptop:/home/./thomas laptop/homedir
# "

SOURCES="
"