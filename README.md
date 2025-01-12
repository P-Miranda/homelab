# Homelab
Repository for homelab configurations and other self-hosted things.

# Docker 
## installation
- install docker by adding [apt
  repositories](https://docs.docker.com/engine/install/debian/#install-using-the-repository)
- add user to docker group (run docker without root)
    - [docs](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user)
    ```bash
    groupadd docker
    usermod -aG docker $USER
    # logout and login
    # check groups
    groups | grep docker
    # test again
    docker run hello-world
    ```

## commands
- Check running dockers: `docker ps`
- Run shell inside running docker:
```bash
docker exec -it <container id> bash
```
- Run docker compose daemon: `docker compose up -d`
    - Note: needs to be in same folder as the respective `docker-compose.yml`
      file
- Stop docker compose daemon: `docker compose down`

## Remove HDD from system
- remove HDD using UI, datacenter -> storage (needs 2 steps, unused and remove)
- if after that, the proxmox still takes a long time during boot waiting for
  the HDD:
    - check `/etc/systemd/system/*.mount` for a service to start that HDD on
      boot
    - disable service and remove it:
    ```bash
    systemctl disable [hdd-ref].mount
    rm /etc/systemd/system/[hdd-ref].moutn
    ```

