FROM docker.io/meshcentral/meshcentral:1.2.4-debian@sha256:f3abd8b10f42038e790689df86432938763c695b16ef67c8e44f75f6da2a92b3
COPY entrypoint.sh /usr/local/bin/meshcentral-railway-entrypoint
RUN chmod +x /usr/local/bin/meshcentral-railway-entrypoint
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/meshcentral-railway-entrypoint"]
