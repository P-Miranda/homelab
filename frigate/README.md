## Camera RTSP Password
- Replace `FRIGATE_RTSP_PASSWORD` in `frigate/config/config.yml` with the
  actual value.

- Replace `FRIGATE_MQTT_USER` and `FRIGATE_MQTT_PASSWORD` in
  `frigate/config/config.yml` with the MQTT server permissions.

## Common Issues
- Not showing camera values:
    - ensure using correct rtsp path (with valid password)
        - run docker with `docker compose up` (no daemon and check logs)
        - if you still get errors, probably you reached the login atempts limit
            - restart/reboot IP camera
- Error restarting frigate docker after update:
```
Error response from daemon: failed to create task for container: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: error during container init: error running hook #0: error running hook: exit status 1, stdout: , stderr: Auto-detected mode as 'legacy'
nvidia-container-cli: initialization error: nvml error: insufficient permissions: unknown
```
    - Re-do instructions for setting up Nvidia GPU Passthrough in LXC,
      specially:
        - blacklist nouveou driver:
        ```bash
        echo "blacklist nouveou" > /etc/modprobe.d/blacklist-nouveou.conf
        echo "options nouveou modeset=0" >> /etc/modprobe.d/blacklist-nouveou.conf
        update-initramfs -u
        reboot
        ```
    - Install latest driver in host and lxc container and reboot
        - NOTE: don't forget to use `./NVIDIA* --no kernel-modules` for lxc
          container driver installation
