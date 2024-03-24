# Pi-hole 2
Second instance of Pi-hole running for redundancy.
- Copy of `pihole/docker-compose.yml`
    - just change `DHCP_START` and `DHCP_END` to avoid conflicts
- symlink for `.env` file
- setup script copies volumes from `pihole`

# Usage
- set webpass (check `pihole/README.md`)
- copy `pihole` configurations: `./setup.sh`
- run docker: `docker compose up -d`


# NOTE
- Raspberry pi as static ip defined in `/etc/dhcpcd.conf`
    - equivalent to `/etc/network/interfaces`


## Install docker in raspberry pi
- [docker
  documentation](https://docs.docker.com/engine/install/raspberry-pi-os/)
