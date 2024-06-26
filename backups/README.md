# Backups
Homelab backup solution.

Current solution uses:
- Local backups: [restic](https://restic.net/) to combine all backed up files
  into a database and provice encryption, deduplication and snapshot
  versioning.
- Off-site backups: [rclone](https://rclone.org/) to access remove cloud
  storage providers
- cron: for periodic backup execution

## NAS Mount Setup
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
    ```bash
    sudo mkdir -p /media/[mount-folder]
    sudo chown [user]:[group] /media/[mount-folder]
    ```

## Restic 

### Installation
- install `bzip2`:
```bash
sudo apt update
sudo apt install bzip2
```
- check `restic_install.sh` script
    - might need to update `VERSION` and `INSTALL_DIR` variables
- run script:
```bash
./restic_install.sh
# insert sudo password
```
- check restic and try to update:
```bash
restic version
restic self-update
```

### Initial Setup
- copy `.env.example` to `.env` and edit accordingly:
```bash
cp .env.example .env
```
- create `.restic-pw` file with repository password
- run `restic_setup_repo.sh` script:
```bash
./restic_setup_repo.sh
```

### Setup Cron job
Edit crontab: `crontab -e`
Add new cronjob:
```
0 3 * * * /path/to/homelab/backups/restic_backup.sh >/dev/null 2>&1
```
- Note: cron job configuration to run daily at 03:00

## Rclone

### Installation
- Install the latest version:
```bash
# NOTE: need to install one of: unzip/7z/busybox
sudo apt update && sudo apt install unzip
sudo -v ; curl https://rclone.org/install.sh | sudo bash
```

### Initial Setup
- Create backblaze B2 bucket
- Follow rclone instructions from [documentation](https://rclone.org/b2/)
    - Optionally: get `rclone.config` file from some backup

### Sync remote
```bash
./rclone_sync.sh
```

### Setup Cron job
Edit crontab: `crontab -e`
Add new cronjob:
```
0 4 * * * /path/to/homelab/backups/rclone_sync.sh >/dev/null 2>&1
```
- Note: cron job configuration to run daily at 04:00

## Global Cron job
The `cron_backup.sh` script runs restic backup followed by rclone sync
Edit crontab: `crontab -e`
Add new cronjob:
```
0 3 * * * /path/to/homelab/backups/cron_backup.sh >/dev/null 2>&1
```
- Note: cron job configuration to run daily at 04:00

## Recovery
- Check some examples on how to recover backed up data:
    - `rclone_recover.sh`: recover data from remote backup to local restic
      repository
    - `restic_recover.sh`: restore lastest snapshot from restic repository to
      specified target directory
