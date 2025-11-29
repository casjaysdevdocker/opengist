#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202511290809-git
# @@Author           :  CasjaysDev
# @@Contact          :  CasjaysDev <docker-admin@casjaysdev.pro>
# @@License          :  MIT
# @@Copyright        :  Copyright 2025 CasjaysDev
# @@Created          :  Sat Nov 29 08:09:47 AM EST 2025
# @@File             :  05-custom.sh
# @@Description      :  script to run custom
# @@Changelog        :  newScript
# @@TODO             :  Refactor code
# @@Other            :  N/A
# @@Resource         :  N/A
# @@Terminal App     :  yes
# @@sudo/root        :  yes
# @@Template         :  templates/dockerfiles/init_scripts/05-custom.sh
# - - - - - - - - - - - - - - - - - - - - - - - - -
# shellcheck disable=SC1001,SC1003,SC2001,SC2003,SC2016,SC2031,SC2090,SC2115,SC2120,SC2155,SC2199,SC2229,SC2317,SC2329
# - - - - - - - - - - - - - - - - - - - - - - - - -
# Set bash options
set -o pipefail
[ "$DEBUGGER" = "on" ] && echo "Enabling debugging" && set -x$DEBUGGER_OPTIONS
# - - - - - - - - - - - - - - - - - - - - - - - - -
# Set env variables
exitCode=0
TMP_DIR="/tmp/opengist"
TMP_BIN="$TMP_DIR/opengist"
TMP_FILE="/tmp/opengist.tar.gz"
BIN_PATH="/usr/local/bin/opengist"
ARCH="$(uname -m | tr '[:upper]' '[:lower]')"
case "$ARCH" in x86_64) ARCH="amd64" ;; aarch64) ARCH="arm64" ;; *) echo "$ARCH is not supported by this script" >&2 && exit 1 ;; esac
API_URL="$(curl -q -LSsf https://api.github.com/repos/thomiceli/opengist/releases/latest | jq -r '.assets[] | select(.name|match("linux.*tar.gz")) | .browser_download_url' | grep "$ARCH.tar.gz" || false)"
# - - - - - - - - - - - - - - - - - - - - - - - - -
# Predefined actions
if [ -n "$API_URL" ]; then
	echo "Dowloading from $API_URL"
	curl -q -LSsf "$API_URL" -o "$TMP_FILE" && tar xzf "$TMP_FILE" -C "/tmp"
	if [ -f "$TMP_DIR/opengist" ]; then
		[ -d "/etc/opengist" ] || mkdir -p "/etc/opengist"
		mv -f "$$TMP_BIN" "$BIN_PATH" && chmod -Rf 755 "$BIN_PATH"
		rm -Rf "$TMP_FILE" "$TMP_DIR"
	else
		exitCode=1
	fi
fi
[ -x "$BIN_PATH" ] && echo "opengist installed to: $BIN_PATH" || exitCode=5
# - - - - - - - - - - - - - - - - - - - - - - - - -
# Main script

# - - - - - - - - - - - - - - - - - - - - - - - - -
# Set the exit code
#exitCode=$?
# - - - - - - - - - - - - - - - - - - - - - - - - -
exit $exitCode
# - - - - - - - - - - - - - - - - - - - - - - - - -
# ex: ts=2 sw=2 et filetype=sh
# - - - - - - - - - - - - - - - - - - - - - - - - -
