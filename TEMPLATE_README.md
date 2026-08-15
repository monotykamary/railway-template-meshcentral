# Deploy and Host MeshCentral on Railway

## About Hosting MeshCentral

MeshCentral is an open-source remote device management platform for browser-based desktop, terminal, files, inventory, events, and agent administration. This template deploys stable version 1.2.5 with a generated full administrator and durable local state.

Sign in with `MESHCENTRAL_ADMIN_USER` and the generated `MESHCENTRAL_ADMIN_PASSWORD` service variable.

## Common Use Cases

- Manage remote desktops, terminals, and files through a browser
- Organize agents into device groups with delegated access
- Audit device inventory, events, sessions, and recordings

## Dependencies for MeshCentral Hosting

### Deployment Dependencies

- One MeshCentral service with a daily-backed-up persistent volume
- Railway managed HTTPS and WebSocket proxying
- Optional external SMTP for invitations and recovery

### Implementation Details

The adapter writes a stable TLS-offload configuration, maps all four writable MeshCentral directories into one volume, creates the initial administrator with the upstream CLI, disables further public registration, and runs MeshCentral on internal HTTP port 8080 with external alias 443. WebRTC is disabled.

This one-replica topology does not represent optional direct TCP, UDP, CIRA, or LAN-discovery listeners. Do not scale horizontally with the local database.

## Why Deploy MeshCentral on Railway?

Railway provides managed HTTPS, a stable public hostname, generated credentials, persistent storage with backups, health checks, and Git-driven rollouts for browser-based remote management.
