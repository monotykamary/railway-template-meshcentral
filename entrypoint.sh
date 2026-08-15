#!/bin/sh
set -eu
: "${MESHCENTRAL_HOSTNAME:?MESHCENTRAL_HOSTNAME is required}"
: "${MESHCENTRAL_SESSION_KEY:?MESHCENTRAL_SESSION_KEY is required}"
: "${MESHCENTRAL_ADMIN_USER:?MESHCENTRAL_ADMIN_USER is required}"
: "${MESHCENTRAL_ADMIN_EMAIL:?MESHCENTRAL_ADMIN_EMAIL is required}"
: "${MESHCENTRAL_ADMIN_PASSWORD:?MESHCENTRAL_ADMIN_PASSWORD is required}"

data_path=/data/meshcentral-data
files_path=/data/meshcentral-files
backups_path=/data/meshcentral-backups
recordings_path=/data/meshcentral-recordings
for path in "$data_path" "$files_path" "$backups_path" "$recordings_path"; do
  mkdir -p "$path"
done
config=$data_path/config.json
if [ ! -f "$config" ]; then
  node <<'JS'
const fs = require('fs');
const config = {
  $schema: 'https://raw.githubusercontent.com/Ylianst/MeshCentral/1.2.5/meshcentral-config-schema.json',
  settings: {
    cert: process.env.MESHCENTRAL_HOSTNAME,
    dataPath: '/data/meshcentral-data',
    filesPath: '/data/meshcentral-files',
    port: 8080,
    aliasPort: 443,
    redirPort: 0,
    WANonly: true,
    sessionKey: process.env.MESHCENTRAL_SESSION_KEY,
    tlsOffload: true,
    trustedProxy: true,
    SelfUpdate: false,
    AllowFraming: false,
    WebRTC: false,
    autoBackup: {
      backupPath: '/data/meshcentral-backups',
      backupOtherFolders: true
    }
  },
  domains: {
    '': {
      title: 'MeshCentral on Railway',
      NewAccounts: false,
      minify: true,
      localSessionRecording: true,
      sessionRecording: {
        filepath: '/data/meshcentral-recordings'
      },
      userNameIsEmail: false
    }
  }
};
fs.writeFileSync('/data/meshcentral-data/config.json', JSON.stringify(config, null, 2));
JS
fi

marker=$data_path/.railway-admin-created
if [ ! -f "$marker" ]; then
  node /opt/meshcentral/meshcentral/meshcentral \
    --datapath "$data_path" \
    --filespath "$files_path" \
    --configfile config.json \
    --createaccount "$MESHCENTRAL_ADMIN_USER" \
    --pass "$MESHCENTRAL_ADMIN_PASSWORD" \
    --email "$MESHCENTRAL_ADMIN_EMAIL" \
    --name "Railway Admin"
  touch "$marker"
fi

unset MESHCENTRAL_ADMIN_PASSWORD MESHCENTRAL_SESSION_KEY
exec node /opt/meshcentral/meshcentral/meshcentral \
  --datapath "$data_path" \
  --filespath "$files_path" \
  --configfile config.json
