# Mosquitto MQTT Server

## Setup
1. Create empty `./config/pwfile` with `0700` permissions:
```bash
touch ./config/pwfile
chmod 0700 ./config/pwfile
```
2. Run docker for the first time
3. Create user from inside docker:
```bash
docker exec -it mosquitto sh
mosquitto_passwd -c /mosquitto/config/pwfile [user]
# write password
# rewrite password
# NOTE if you get a warning, change pwfile permissions to root:root
```
