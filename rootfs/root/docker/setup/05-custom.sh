#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202408091650-git
# @@Author           :  CasjaysDev
# @@Contact          :  CasjaysDev <docker-admin@casjaysdev.pro>
# @@License          :  MIT
# @@ReadME           :
# @@Copyright        :  Copyright 2023 CasjaysDev
# @@Created          :  Mon Aug 28 06:48:42 PM EDT 2023
# @@File             :  05-custom.sh
# @@Description      :  script to run custom
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck shell=bash
# shellcheck disable=SC2016
# shellcheck disable=SC2031
# shellcheck disable=SC2120
# shellcheck disable=SC2155
# shellcheck disable=SC2199
# shellcheck disable=SC2317
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set bash options
set -o pipefail
[ "$DEBUGGER" = "on" ] && echo "Enabling debugging" && set -x$DEBUGGER_OPTIONS
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set env variables
ARCH="$(uname -m | tr '[:upper]' '[:lower]')"
exitCode=0
BIN_PATH="/usr/local/bin/opengist"
case "$ARCH" in x86_64) ARCH="amd64" ;; aarch64) ARCH="arm64" ;; *) echo "$ARCH is not supported by this script" >&2 && exit 1 ;; esac
API_URL="$(curl -q -LSsf https://api.github.com/repos/thomiceli/opengist/releases/latest | jq -r '.assets[] | select(.name|match("linux.*tar.gz")) | .browser_download_url' | grep "$ARCH.tar.gz" || false)"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Main script
if [ -n "$API_URL" ]; then
  echo "Dowloading from $API_URL"
  curl -q -LSsf "$API_URL" -o "/tmp/opengist.tar.gz" && tar xzf /tmp/opengist.tar.gz -C "/tmp"
  if [ -f "/tmp/opengist/opengist" ]; then
    [ -d "/etc/opengist" ] || mkdir -p "/etc/opengist"
    mv -f "/tmp/opengist/opengist" "$BIN_PATH" && chmod -Rf 755 "$BIN_PATH"
    rm -Rf "/tmp/opengist.tar.gz" "/tmp/opengist"
    [ -x "$BIN_PATH" ] && echo "opengist installed to: $BIN_PATH" || exitCode=5
  else
    exitCode=1
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set the exit code
[ $exitCode -eq 0 ] || echo "Failed to install opengist" >&2
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
exit $exitCode
