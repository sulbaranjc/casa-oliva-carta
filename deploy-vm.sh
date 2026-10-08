#!/usr/bin/env bash
set -euo pipefail

archive=/tmp/casa-oliva-site.tar.gz
stage=/tmp/casa-oliva-stage
site=/var/www/casa-oliva

mkdir -p "$stage" "$site/assets"
tar -xzf "$archive" -C "$stage"
install -m 0644 "$stage/index.html" "$site/index.html"
install -m 0644 "$stage/styles.css" "$site/styles.css"
install -m 0644 "$stage/assets/hero.webp" "$site/assets/hero.webp"
install -m 0644 "$stage/assets/favicon.svg" "$site/assets/favicon.svg"
install -m 0644 "$stage/nginx.conf" /etc/nginx/sites-available/casa-oliva
ln -sfn /etc/nginx/sites-available/casa-oliva /etc/nginx/sites-enabled/casa-oliva
if [[ -L /etc/nginx/sites-enabled/default ]]; then
  unlink /etc/nginx/sites-enabled/default
fi
nginx -t
systemctl enable --now nginx
systemctl reload nginx
curl -fsSI http://127.0.0.1/
