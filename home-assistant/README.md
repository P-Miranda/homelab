# Home Assistant

## Database
Home Assistant runs sqlite dabatabe by default.
This can give performance problems down the road.

Use custom postgres database instead.

Change `{HA_DB_PASSWORD}` for you actual database password in
`docker-compose.yml` and `config/configuration.yaml`.
