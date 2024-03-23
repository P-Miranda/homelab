# Pi-Hole Docker Image
## Documentation
- [Pi-hole documentation](https://docs.pi-hole.net/)
- [Pi-hole Docker](https://github.com/pi-hole/docker-pi-hole)

## Local DNS Records
- Add local DNS records (for example for device ips) in
  `./etc-pihole/custom.list`
    - example:
    ```
    # ./etc-pihole/custom.list
    [IP] [domain]
    192.168.1.8 mydomain1.lan
    192.168.1.9 mydomain2.lan
    ```

## Secrets
- Current configuration uses [docker
  secret](https://docs.docker.com/engine/swarm/secrets/) for webpassword
- Secrets are automatically created by docker compose. The only thing that
  needs to be done is to create the `webpass.txt` file with the contents:
```
[web_password]
```

## Static IP for VM and Proxmox Host
- Set static IPs for Proxmox Host and VM that runs DHCP server, since they need
  to boot before the dhcp server stats
### static ip in debian 12
- Edit the `/etc/interfaces` file:
```
# replace dhcp iface
allow-hotplug eth0
iface eth0 inet dhcp
# static configuration
auto eth0
iface eth0 inet static
address [static IP]
netmask 255.255.255.0
gateway [router IP]
dns-nameservers [dns/pi-hole IP]
```
