FROM ubuntu:24.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

ARG PICO_SDK_VERSION=2.2.0

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

# Clone actual pico-sdk
RUN git clone --depth=1 --branch ${PICO_SDK_VERSION} https://github.com/raspberrypi/pico-sdk.git

# Build pioasm
WORKDIR /build/pico-sdk/tools/pioasm

RUN cmake -B build -S . \
    -DPIOASM_VERSION_STRING=${PICO_SDK_VERSION} \
    && cmake --build build -j$(nproc) \
    && strip build/pioasm

# Minimal runtime image
FROM ubuntu:24.04

COPY --from=builder /build/pico-sdk/tools/pioasm/build/pioasm /usr/local/bin/pioasm

ENTRYPOINT ["pioasm"]
