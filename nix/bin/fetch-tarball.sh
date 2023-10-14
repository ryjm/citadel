#!/usr/bin/env bash

release_json=$(curl --silent "https://api.github.com/repos/urbit/urbit/releases/latest" -H "Accept: application/vnd.github+json")

tarball_url=$(echo "$release_json" | jq -r '.assets[] | select(.name | endswith("linux-x86_64.tar.xz")) | .browser_download_url')
echo "Downloading $tarball_url"
curl --location --remote-name --silent "$tarball_url"
