# Uptime Kuma
Self-hosted program to check services and other programs uptime.
Allows for notification if a service goes offline.

- [Official Documentation](https://github.com/louislam/uptime-kuma/wiki)

## Pi-hole Checks:
- Actually use DNS to check if is working.
```
Monitor Type: DNS
Hostname: www.example.com # (hostname to resolve)
Resolver Server: 192.168.1.11 # (your pi-hole IP address)
Port: 53
Resource Record Type: A # (might vary based on the hostname you want to resolve)
```
