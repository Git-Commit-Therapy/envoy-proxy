FROM envoyproxy/envoy:v1.31-latest

COPY envoy.yaml etc/envoy/envoy.yaml
# RUN chmod go+r /etc/envoy/envoy.yaml
# Fail the build if the config is invalid
RUN ["envoy", "--mode validate", "-c", "/etc/envoy/envoy.yaml"]

LABEL org.opencontainers.image.source=https://github.com/Git-Commit-Therapy/envoy-proxy

ENTRYPOINT ["/usr/local/bin/envoy"]
CMD ["-c", "/etc/envoy/envoy.yaml"]
