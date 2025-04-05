# Wireguard VPN
- [Official page](https://www.wireguard.com/)
- [Web UI Docker](https://github.com/wg-easy/wg-easy)

## Requirements
- Set dynamic dns (check `ddns`)
- Port forward wireguard `WG_PORT` (default 51820) in router
    - UDP protocol only

- instead of password in environment variable, use `PASSWORD_HASH`:
```bash
docker run ghcr.io/wg-easy/wg-easy wgpw YOUR_PASSWORD
# outputs something like: 
# PASSWORD_HASH='$2b$12$coPqCsPtcFO.Ab99xylBNOW4.Iu7OOA2/ZIboHN6/oyxca3MWo7fW'
# REPLACE all '$' by double '$$' in `docker-compose.yaml`
```
