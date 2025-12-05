# syntax=docker/dockerfile:1.7

FROM caddy:2.10.2-builder AS builder
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build \
        --with github.com/ueffel/caddy-brotli \
        --with github.com/caddy-dns/cloudflare \
        --with github.com/greenpau/caddy-security \
        --with github.com/hslatman/caddy-crowdsec-bouncer/http \
        --with github.com/hslatman/caddy-crowdsec-bouncer/layer4 \
        --with github.com/hslatman/caddy-crowdsec-bouncer/appsec


FROM caddy:2.10.2
COPY --from=builder /usr/bin/caddy /usr/bin/caddy