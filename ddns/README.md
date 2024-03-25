# DDNS
Using DuckDNS for dynamic DNS

## Login to DuckDNS
- [check domains](https://www.duckdns.org/domains)

## Requirements:
- crontab
- curl
```bash
sudo apt update
sudo apt install cron curl
```

## Add .env variables
- Create `.env` file:
```bash
DOMAIN=[DOMAIN]
TOKEN=[TOKEN]
```
- Note: use values from duckdns site

## Setup crontab
Edit crontab: `crontab -e`
Add new cronjob:
```
* * * * * /path/to/homelab/ddns/duckdns.sh >/dev/null 2>&1
```
- Note: cron job configuration to update every minute
