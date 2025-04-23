# Immitch Self-hosted photo and video management
- [Official Site](https://immich.app/)

- Use external libraries to add existing photos and videos to immich:
```yaml
    volumes:
      # Do not edit the next line. If you want to change the media storage location on your system, edit the value of UPLOAD_LOCATION in the .env file
      - ${UPLOAD_LOCATION}:/usr/src/app/upload
      - /etc/localtime:/etc/localtime:ro
      - /media/NAS/media/photos:/mnt/media/nas-photos:ro
```
- check [Documentation](https://immich.app/docs/guides/external-library/) for
  more information

- Original photos are stored in `UPLOAD_LOCATION`
    - currently backing up:
    ```
    UPLOAD_LOCATION/library
    UPLOAD_LOCATION/upload
    UPLOAD_LOCATION/profile
    ```
