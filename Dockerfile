# Stage 1: get tofu binary
FROM ghcr.io/opentofu/opentofu:minimal AS builder

# Stage 2: base environment for CI
FROM alpine:3.20

# Copy tofu binary from builder
COPY --from=builder /usr/local/bin/tofu /usr/local/bin/tofu

# Install needed tools
RUN apk add --no-cache bash git

WORKDIR /build