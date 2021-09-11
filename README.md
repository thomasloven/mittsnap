# Mittsnap

Rsnapshot-inspired backup management tool which leverages btrfs snapshots.

## Why?

I've been using [rsnapshot](https://rsnapshot.org/) for backing up my home server and other computers on the network.

However, my server is using btrfs, and I was thinking I should be able to leverage the COW snapshots to save disk space and speed things up.

Unfortunately, I couldn't find a tool that did this... so here it is.

It currently saves me 7 hours on each daily backup compared to rsync (btrfs is kind of bad with lots of small files).

## Disclaimer

This is just a shell script, and I have pretty much no idea what I'm doing.
This is provided as-is and I take no responsibility for its functionality or any data loss resulting from its use.

I have not tested this as much as I should have.

## Installation

- copy `mittsnap` to somewhere `root` can run it from, e.g. `/usr/local/bin/
- copy `mittsnap.conf.sh` to `/etc/mittsnap.conf.sh`
- create a directory `/backup` for the backups

## How it works
Mittsnap works with a rotating backup scheme. A new daily backup is started with `mittsnap daily`. By default 7 daily backups are retained, and any beyond that are removed.

When running `mittsnap weekly`, the oldest daily backup is copied to a weekly backup (only if 7 daily backups exist). By default 4 weekly backups are retained.

When running `mittsnap monthly` the oldest weekly backup is copied to a monthly backup. By default 120 monthly backups are retained.

A new daily backup is created like this:
- Backups of btrfs subvolumes are snapshotted into `daily.0/`.
- Rsync based backups (local or over ssh) are rsynced to the btrfs subvolume `daily.0/local/`.

It's only ever `daily.0/local` that can be written to (and is by rsync). All other backups are read-only snapshots of copy-on-write subvolumes, so everything is lightning fast.

## Configuration
Configuration is made through `/etc/mittsnap.conf.sh`. A different configuration script can be used with `mittsnap -c FILE`.

The variables are explained in the file, but there are two changes you need to make.
The first one is `SOURCES` which should be a list of sources to backup from in the format:
```bash
SOURCES="
<protocol> <source> <target>
<protocol> <source> <target>
...
"
```

`<protocol>` can be `snapshot`, `local` or `ssh`.

Ex:
```bash
SOURCES="
snapshot /data/photos photos
local /home/./thomasloven server/homedir
ssh thomas@laptop:/home/./thomas laptop/homedir
"
```

This will:
- Make a snapshot of btrfs subvolume `/data/photos` i `daily.0/photos`
- rsync `/home/thomasloven` into `daily.0/local/server/homedir/thomasloven`
- rsync `/home/thomas` on the host `laptop` into `daily.0/local/laptop/homedir/thomas` through ssh.

Note that the `/./` is an rsync feature to discard the left part of the path.

The second change you need to make is to uncomment the line
```bash
DRYRUN=0
```
Otherwise Mittsnap won't *actually* do anything.

Before doing this, I recommend actually making a config check with `mittsnap config` and a test run with `mittsnap -vvv daily` to see what it will do.

Try `mittsnap -h` for more usage options.

## Automating

Example crontab:
```cron
0 0     * * *   root /usr/local/bin/mittsnap daily
2 0     * * 1   root /usr/local/bin/mittsnap weekly
4 0     1 * *   root /usr/local/bin/mittsnap monthly
```

---
<a href="https://www.buymeacoffee.com/uqD6KHCdJ" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/white_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a>