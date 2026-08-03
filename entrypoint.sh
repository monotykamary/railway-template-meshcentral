#!/bin/sh
set -eu
: "${MESHCENTRAL_HOSTNAME:?MESHCENTRAL_HOSTNAME is required}"
: "${MESHCENTRAL_SESSION_KEY:?MESHCENTRAL_SESSION_KEY is required}"
: "${MESHCENTRAL_ADMIN_USER:?MESHCENTRAL_ADMIN_USER is required}"
: "${MESHCENTRAL_ADMIN_EMAIL:?MESHCENTRAL_ADMIN_EMAIL is required}"
: "${MESHCENTRAL_ADMIN_PASSWORD:?MESHCENTRAL_ADMIN_PASSWORD is required}"

for name in data files backups web; do
  mkdir -p "/data/meshcentral-$name"
  rm -rf "/opt/meshcentral/meshcentral-$name"
  ln -s "/data/meshcentral-$name" "/opt/meshcentral/meshcentral-$name"
done
config=/opt/meshcentral/meshcentral-data/config.json
if [ ! -f "$config" ]; then
  node <<'JS'
const fs = require('fs');
const config = {
  $schema: 'https://raw.githubusercontent.com/Ylianst/MeshCentral/1.2.4/meshcentral-config-schema.json',
  settings: {
    cert: process.env.MESHCENTRAL_HOSTNAME,
    port: 8080,
    aliasPort: 443,
    redirPort: 0,
    WANonly: true,
    sessionKey: process.env.MESHCENTRAL_SESSION_KEY,
    tlsOffload: true,
    trustedProxy: true,
    SelfUpdate: false,
    AllowFraming: false,
    WebRTC: false
  },
  domains: {
    '': {
      title: 'MeshCentral on Railway',
      NewAccounts: false,
      minify: true,
      localSessionRecording: true,
      userNameIsEmail: false
    }
  }
};
fs.writeFileSync('/opt/meshcentral/meshcentral-data/config.json', JSON.stringify(config, null, 2));
JS
fi

marker=/opt/meshcentral/meshcentral-data/.railway-admin-created
if [ ! -f "$marker" ]; then
  node /opt/meshcentral/meshcentral/meshcentral \
    --configfile "$config" \
    --createaccount "$MESHCENTRAL_ADMIN_USER" \
    --pass "$MESHCENTRAL_ADMIN_PASSWORD" \
    --email "$MESHCENTRAL_ADMIN_EMAIL" \
    --name "Railway Admin"
  touch "$marker"
fi

unset MESHCENTRAL_ADMIN_PASSWORD MESHCENTRAL_SESSION_KEY
exec node /opt/meshcentral/meshcentral/meshcentral --configfile "$config"
