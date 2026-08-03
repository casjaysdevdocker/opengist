#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202608031101-git
# @@Author           :  CasjaysDev
# @@Contact          :  CasjaysDev <docker-admin@casjaysdev.pro>
# @@License          :  WTFPL
# @@Copyright        :  Copyright 2026 CasjaysDev
# @@Created          :  Mon Aug  3 11:01:46 AM EDT 2026
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
set -eo pipefail
[ "$DEBUGGER" = "on" ] && echo "Enabling debugging" && set -x$DEBUGGER_OPTIONS
# - - - - - - - - - - - - - - - - - - - - - - - - -
VERSION="202608031101-git"
# - - - - - - - - - - - - - - - - - - - - - - - - -
# Set env variables
OPENGIST_EXITCODE=0
OPENGIST_TMP_DIR="/tmp/opengist"
OPENGIST_TMP_BIN="$OPENGIST_TMP_DIR/opengist"
OPENGIST_TMP_FILE="/tmp/opengist.tar.gz"
OPENGIST_BIN_PATH="/usr/local/bin/opengist"
ARCH="$(uname -m | tr '[:upper]' '[:lower]')"
case "$ARCH" in x86_64) ARCH="amd64" ;; aarch64) ARCH="arm64" ;; *) echo "$ARCH is not supported by this script" >&2 && exit 1 ;; esac
OPENGIST_API_URL="$(curl -4 -q -LSsf https://api.github.com/repos/thomiceli/opengist/releases/latest | jq -r '.assets[] | select(.name|match("linux.*tar.gz")) | .browser_download_url' | grep -- "$ARCH.tar.gz" || false)"
# - - - - - - - - - - - - - - - - - - - - - - - - -
# Predefined actions
if [ -n "$OPENGIST_API_URL" ]; then
	echo "Dowloading from $OPENGIST_API_URL"
	curl -4 -q -LSsf "$OPENGIST_API_URL" -o "$OPENGIST_TMP_FILE" && tar xzf "$OPENGIST_TMP_FILE" -C "/tmp"
	if [ -f "$OPENGIST_TMP_DIR/opengist" ]; then
		[ -d "/etc/opengist" ] || mkdir -p "/etc/opengist"
		mv -f "$OPENGIST_TMP_BIN" "$OPENGIST_BIN_PATH" && chmod -Rf 755 "$OPENGIST_BIN_PATH"
		rm -Rf "$OPENGIST_TMP_FILE" "$OPENGIST_TMP_DIR"
	else
		OPENGIST_EXITCODE=1
	fi
fi
[ -x "$OPENGIST_BIN_PATH" ] && echo "opengist installed to: $OPENGIST_BIN_PATH" || OPENGIST_EXITCODE=5
# - - - - - - - - - - - - - - - - - - - - - - - - -
# Main script

# - - - - - - - - - - - - - - - - - - - - - - - - -
# Set the exit code
# - - - - - - - - - - - - - - - - - - - - - - - - -
exit "$OPENGIST_EXITCODE"
# - - - - - - - - - - - - - - - - - - - - - - - - -
# ex: ts=2 sw=2 et filetype=sh
# - - - - - - - - - - - - - - - - - - - - - - - - -
