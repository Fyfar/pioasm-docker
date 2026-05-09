# pioasm Docker image

This repository provides a minimal Docker image for `pioasm` (Raspberry Pi Pico PIO assembler), built from the latest Raspberry Pi Pico SDK.

The original project this is based on is no longer actively maintained, so this fork updates the build to use the current SDK and fixes compatibility with newer `pioasm` requirements.

## Why this fork exists

The upstream Docker image used an outdated `pico-sdk` version, which caused build issues with newer PIO assembly syntax (e.g. `.pio_version` directive).  
This version tracks the active Raspberry Pi SDK repository and ensures compatibility with current examples and tooling.

## Run
`docker run --rm fyfar/pioasm:2.2.0 --version`

Compile a .pio file:
```
docker run --rm \
  -v $(pwd):/work \
  -w /work \
  fyfar/pioasm:2.2.0 \
  input.pio output.h
```

https://hub.docker.com/r/fyfar/pioasm
