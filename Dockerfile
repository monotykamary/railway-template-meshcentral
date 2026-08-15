FROM docker.io/meshcentral/meshcentral:1.2.5-debian@sha256:916a771ff22676fbe70526a21487ce2cbfb24586466c52bb00e3c5544006a623
COPY entrypoint.sh /usr/local/bin/meshcentral-railway-entrypoint
RUN chmod +x /usr/local/bin/meshcentral-railway-entrypoint
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/meshcentral-railway-entrypoint"]
