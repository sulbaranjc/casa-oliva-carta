#!/usr/bin/env bash
set -euo pipefail

repo=/srv/casa-oliva
site_config=/etc/nginx/sites-available/casa-oliva

if [[ ! -f "$repo/public/index.html" || ! -f "$repo/nginx.conf" ]]; then
  printf 'Falta el clon de Casa Oliva en %s\n' "$repo" >&2
  exit 1
fi

install -m 0644 "$repo/nginx.conf" "$site_config"
ln -sfn "$site_config" /etc/nginx/sites-enabled/casa-oliva
if [[ -L /etc/nginx/sites-enabled/default ]]; then
  unlink /etc/nginx/sites-enabled/default
fi
nginx -t
systemctl enable --now nginx
systemctl reload nginx
sleep 1
curl -fsS http://127.0.0.1/ | grep -F '<title>Carta · Casa Oliva</title>'
