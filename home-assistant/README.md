# Home Assistant

## Database
Home Assistant runs sqlite dabatabe by default.
This can give performance problems down the road.

Use custom postgres database instead.

Change `{HA_DB_PASSWORD}` for you actual database password in
`docker-compose.yml` and `config/configuration.yaml`.

## HACS: Home Assistant Community Store
- Frigate integration requires HACS installed
    - check docs [here](https://hacs.xyz/docs/setup/download)

- save this
```yaml
lovelace:
  resources:
    - url: /hacsfiles/frigate-hass-card/frigate-hass-card.js
      type: module
```
