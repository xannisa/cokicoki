FROM ghcr.io/opentofu/opentofu:minimal AS tofu

FROM alpine:3.20

# Copy OpenTofu binary
COPY --from=tofu /usr/local/bin/tofu /usr/local/bin/tofu

# Install required tools
RUN apk add --no-cache \
    git \
    curl \
    ca-certificates \
    openssh-client

# Set working directory
WORKDIR /workspace

# Make tofu the default command
ENTRYPOINT ["tofu"]