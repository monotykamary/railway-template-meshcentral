# MeshCentral on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/meshcentral?referralCode=ZqgrJ0)

Deploy MeshCentral 1.2.5 with a generated full administrator, persistent device state, files, recordings, certificates, and backups.

The Deploy on Railway button is added after the published route is verified.

## What this deploys

- MeshCentral `1.2.5-debian`, pinned to the official Linux/AMD64 image digest
- Local MeshCentral database and all writable directories on one daily-backed-up volume
- Generated administrator password and stable session key
- Plain HTTP behind Railway's managed HTTPS proxy with external port alias `443`

## Sign in

Open the generated domain and sign in with `MESHCENTRAL_ADMIN_USER` and the generated `MESHCENTRAL_ADMIN_PASSWORD`. The adapter creates the first account through MeshCentral's built-in CLI and disables additional public account creation.

## Scope and networking

MeshCentral's browser-based agent management, terminal, desktop, and file channels use HTTPS and WebSockets through the generated Railway domain. WebRTC is disabled. Features that require direct inbound TCP listeners, UDP, Intel AMT CIRA ports outside the web endpoint, or LAN discovery are not represented by this template.

The local database and filesystem topology is intentionally one replica. Do not scale horizontally. Configure SMTP, two-factor authentication, domain security, device-group permissions, and off-platform backups before production use.

## Updating

Update the pinned version and digest deliberately, back up the volume, review upstream changes, then repeat account login, device-group creation, file persistence, WebSocket/agent enrollment, backup, and redeploy soak tests.

## Validation

```bash
npm test
BASE_URL=https://your-domain.example ADMIN_USER=admin ADMIN_PASSWORD=... python3 scripts/smoke.py
```

## Upstream

- Source: https://github.com/Ylianst/MeshCentral/tree/1.2.5
- Release: https://github.com/Ylianst/MeshCentral/releases/tag/1.2.5
- Docker documentation: https://github.com/Ylianst/MeshCentral/blob/1.2.5/docker/README.md
- License: Apache License 2.0

This repository contains Railway adapters and documentation. MeshCentral remains copyright its upstream contributors and is not affiliated with Railway.
