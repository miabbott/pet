#!/bin/bash
# Test script for validating the chunkah multi-stage build locally.
set -xeuo pipefail

TOOLBOX="quay.io/rhel-devel-tools/rhel-developer-toolbox:latest"
TAG="pet:chunkah"

podman pull "$TOOLBOX"

# -v and --security-opt are required for buildah < 1.44 to make the
# RUN --mount=type=bind write the OCI archive into the build context
podman build \
  --skip-unused-stages=false \
  --build-arg "CHUNKAH_CONFIG_STR=$(podman inspect "$TOOLBOX")" \
  --from "$TOOLBOX" \
  -v "$(pwd):/run/src" \
  --security-opt=label=disable \
  -t "$TAG" .

layer_count=$(podman inspect "$TAG" | jq '.[0].RootFS.Layers | length')
echo "Layer count: $layer_count"

if [ "$layer_count" -le 2 ]; then
  echo "WARNING: expected many layers from chunkah splitting, got $layer_count"
  exit 1
fi

echo "Build successful with $layer_count content-based layers"
