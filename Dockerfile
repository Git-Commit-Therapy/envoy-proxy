FROM envoyproxy/envoy:v1.31-latest

COPY envoy.yaml etc/envoy/envoy.yaml

# Fake CA certs for testing
RUN mkdir /etc/envoy/trust && touch /etc/envoy/trust/root-certs.pem

# Fail the build if the config is invalid
RUN ["envoy", "--mode validate", "-c", "/etc/envoy/envoy.yaml"]
# Remove the fake CA certs
RUN rm -r /etc/envoy/trust

LABEL org.opencontainers.image.source=https://github.com/Git-Commit-Therapy/envoy-proxy

VOLUME /etc/envoy/certs
VOLUME /etc/envoy/trust

ENTRYPOINT ["/usr/local/bin/envoy"]
CMD ["-c", "/etc/envoy/envoy.yaml"]
