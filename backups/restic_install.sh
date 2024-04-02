#!/usr/bin/env bash

# Update the version number if needed - choose latest by default
# check: https://github.com/restic/restic/releases
VERSION=0.16.4

INSTALL_DIR=/usr/local/bin

OUTPUT=restic.bz2
URL="https://github.com/restic/restic/releases/download/v${VERSION}/restic_${VERSION}_linux_386.bz2"

wget $URL -O $OUTPUT        # Download
bzip2 -d $OUTPUT            # Decompress
chmod +x restic             # Make executable
sudo mv restic $INSTALL_DIR # Move to install directory
rm -f $OUTPUT               # Clean up
