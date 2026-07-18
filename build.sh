#!/usr/bin/env bash
# ShalaOS ISO build launcher.
# Builds the Docker image (once) and runs mkarchiso inside a privileged
# container, so nothing touches the host except this project folder and
# the "out/" directory where the finished .iso lands.
set -euo pipefail

cd "$(dirname "$0")"

IMAGE_NAME="shalaos-builder"
OUT_DIR="$(pwd)/out"

mkdir -p "$OUT_DIR"

docker build -t "$IMAGE_NAME" .

# work dizini kasten container icinde (volume DEGIL): mkarchiso squashfs/loop
# islemleri overlay volume uzerinde sorun cikarabiliyor ve work kalintilari
# host'ta root sahipli cop birakiyor.
docker run --rm -it \
  --privileged \
  -v "$(pwd)/profile:/build/profile:ro" \
  -v "$OUT_DIR:/build/out:rw" \
  -w /build \
  "$IMAGE_NAME" \
  bash -c '
    set -e
    mkarchiso -v -w /tmp/archiso-work -o /build/out /build/profile
  '

echo
echo "Bitti. ISO dosyasi burada: ${OUT_DIR}"
