#!/usr/bin/env bash
set -euo pipefail

WASI_SDK_VERSION="${1:-latest}"

echo "::group::Determining which WASI-SDK version to use"
if [ "$WASI_SDK_VERSION" == "latest" ]; then
# Fetch the latest WASI SDK version
WASI_SDK_VERSION=$(wget -q -O - https://api.github.com/repos/WebAssembly/wasi-sdk/releases/latest |
  jq -r '.tag_name' | 
  sed 's/^wasi-sdk-//')
fi
echo "Using WASI SDK version: $WASI_SDK_VERSION"
echo "::endgroup::"


# Output the version for GitHub Actions
echo "WASI_SDK_VERSION=$WASI_SDK_VERSION" >> "$GITHUB_ENV"
echo "version=$WASI_SDK_VERSION" >> "$GITHUB_OUTPUT"
