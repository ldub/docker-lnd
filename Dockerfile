FROM golang:1.12-alpine as builder

# Define what version of lightningnetwork/lnd to use
ARG NIGIRI_LND_VERSION
ENV NIGIRI_LND_VERSION ${NIGIRI_LND_VERSION:-"v0.7.0-beta"}

# Force Go to use the cgo based DNS resolver. This is required to ensure DNS
# queries required to connect to linked containers succeed.
ENV GODEBUG netdns=cgo

# Install dependencies and install/build lnd.
RUN apk add --no-cache --update alpine-sdk git make \
  && git clone --branch v0.7.0-beta --depth 1 https://github.com/lightningnetwork/lnd \
  && cd lnd \
  && make \
  && make install

# Start a new, final image to reduce size.
FROM alpine as final

# Copy the binaries and entrypoint from the builder image.
COPY --from=builder /go/bin/lncli /bin/
COPY --from=builder /go/bin/lnd /bin/

# Add bash.
RUN apk add --no-cache bash

# Define entrypoint
ENTRYPOINT ["/bin/lnd"]
