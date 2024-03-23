# Homelab
Repository for homelab configurations and other self-hosted things.

# Docker commands
- Check running dockers: `docker ps`
- Run shell inside running docker:
```bash
docker exec -it <container id> bash
```
- Run docker compose daemon: `docker compose up -d`
    - Note: needs to be in same folder as the respective `docker-compose.yml`
      file
- Stop docker compose daemon: `docker compose down`

