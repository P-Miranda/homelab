# Backups
Homelab backup solution.

Current solution uses:
- Local backups: [restic](https://restic.net/) to combine all backed up files
  into a database and provice encryption, deduplication and snapshot
  versioning.
- Off-site backups: [rclone](https://rclone.org/) to access remove cloud
  storage providers
- cron: for periodic backup execution

## Setup
- install `cifs-utils`: `sudo apt update; sudo apt install cifs-utils`
Mount NAS storage as network mount
- create `$HOME/.nas_credentials` file with correct user credentials:
```
username=[user]
password=[password]
```
- Edit `/etc/fstab` to add network mount:
```
# Network folder
//[NAS-IP]/[folder] /media/[mount-folder] cifs credentials=/home/[user]/.nas_credentials,_netdev,iocharset=utf8,uid=1000,gid=1000,noauto,x-systemd.automount 0 0
```

### Notes
- `noauto` makes ignoring mounting with `sudo mount -a`
    - reboot machine to get new mounts
- it may be necessary to update ownership of new mount folders, update with:
    ```
    sudo chown [user]:[group] /path/to/mount
    ```
