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
