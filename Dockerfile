FROM docker.io/meshcentral/meshcentral:1.2.6-debian@sha256:4aa1351301a3ec947d79b4b250dad2f2cc3d85f04bbe3774dab495af5bbda479
COPY entrypoint.sh /usr/local/bin/meshcentral-railway-entrypoint
RUN chmod +x /usr/local/bin/meshcentral-railway-entrypoint
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/meshcentral-railway-entrypoint"]
