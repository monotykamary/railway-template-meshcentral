FROM docker.io/meshcentral/meshcentral:1.3.1-debian@sha256:295f2781dad218eea01efd899894442c588a6deec0a5b7de5f7e1d6c37058367
COPY entrypoint.sh /usr/local/bin/meshcentral-railway-entrypoint
RUN chmod +x /usr/local/bin/meshcentral-railway-entrypoint
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/meshcentral-railway-entrypoint"]
