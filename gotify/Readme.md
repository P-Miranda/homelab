# Gotify
Simple server to send and receive notifications

- [Official documentation](https://gotify.net/docs/)

## Setup
```bash
cp .env.example .env
# edit .env with correct variable values
# run docker
docker compose up -d
```
- login to WebUI:
    - [VM IP]:PORT (default 8080)
    - use password in `.env`
- create users
- create application for each user

## Push messages
- `push_message.sh` script is an example to push messages to gotify server
- check [documentation](https://gotify.net/docs/more-pushmsg) for more examples

## Install android application
- configure with user credentials
- also can send push notifications
