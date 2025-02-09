#!/usr/bin/env bash
set -euo pipefail

WASI_SYSROOT="${WASI_SYSROOT:-/opt/wasi-sysroot}"
CACHE_PATH=.github/cache
CACHE_FILE=${CACHE_PATH}/wasi-sysroot.tar.gz
WASI_SDK_VERSION=${WASI_SDK_VERSION:-latest}

if [ -f "$CACHE_FILE" ]; then
  echo "Cached version found"
else
  echo "::group::Downloading WASI-SDK sysroot version ${WASI_SDK_VERSION}"
  mkdir -p ${CACHE_PATH}
  WASI_SYSROOT_URL="https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-${WASI_SDK_VERSION}/wasi-sysroot-${WASI_SDK_VERSION}.0.tar.gz"
  wget -nv "$WASI_SYSROOT_URL" -O ${CACHE_FILE}
  echo "::endgroup::"
fi

echo "::group::Extracting and installing WASI sysroot"
mkdir -p "$WASI_SYSROOT"
tar -xzf ${CACHE_FILE} -C "$WASI_SYSROOT" --strip-components=1
echo "WASI_SYSROOT=$WASI_SYSROOT" >> "$GITHUB_ENV"
echo "::endgroup::"

echo "Installation complete."
