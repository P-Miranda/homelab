# Cloud-init
Cloud-init is a type of image that can be used to automatically install an OS
with some set of configuration.
TLDR: automatically install OS without manual setup.

### Usefull links
    
- [Promox Wiki](https://pve.proxmox.com/wiki/Cloud-Init_Support)
- [Jim's Garage Video](https://www.youtube.com/watch?v=Kv6-_--y5CM)
- [Blog tutorial](https://pycvala.de/blog/proxmox/create-your-own-debian-12-cloud-init-template/)
- [Another blog post](https://www.apalrd.net/posts/2023/pve_cloud/)

### Debian 12 Cloud-init
- Set variables in `.env` file. Use `.env.example` as template.
- copy `create_template.sh`, `.env` and `[ssh-key.pub]` files to proxmox
    ```bash
    scp create_template.sh [user]@[proxmox-machine]:/var/lib/vz/template/iso/
    scp .env [user]@[proxmox-machine]:/var/lib/vz/template/iso/
    scp [ssh-key.pub] [user]@[proxmox-machine]:/var/lib/vz/template/iso/
    scp create_template.sh root@proxmox.lan:/var/lib/vz/template/iso/
    scp .env root@proxmox.lan:/var/lib/vz/template/iso/
    scp ~/.ssh/hlab-vm.pub root@proxmox.lan:/var/lib/vz/template/iso/
    ```
- Download [debian 12 generic amd64
  image](https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2)
```bash
cd /var/lib/vz/template/iso/
wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2
```
    - NOTE: Promox WebGUI doesn't seem to allow for downloading .qcow2 images
      from URL. So just do this step from the command line
- Create VM template with `create_template.sh` script
    - check script for details and other manual changes
- Check template `hardware` settings in WebGUI
    - change things like, cpu cores (use host cpu type), RAM, etc
    - **NOTE**: do not run `qm template $ID` command if you want to change settings
      before creating template
    - Edit `cloud-init` settings:
        - user, password, etc
        - ip configuration -> set to DHCP
- Create VM from template
    - template -> right click -> clone
        - Name
        - Full clone
    - check new vm settings
    - add new VM mac address to DHCP server static leases
    - recommendation: install `qemu-guest-agent`

## Create ssh keys
```bash
ssh-keygen -t ecdsa -b 521 -f ~/.ssh/[new-key]
# choose passphrase and repeat
# add to agent
eval `ssh-agent`
ssh-add ~/.ssh/[new-key]
```

## Recommendations
- save ssh keypair in password manager
    - so you can reuse the ssh keypair to access from any machine via ssh
- still set password for access via proxmox webgui (VM terminal)
    - ssh access via password in disabled by default
