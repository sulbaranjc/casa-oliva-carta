# Casa Oliva · carta web de demostración

Sitio estático de una sola página para el taller de Ubuntu Server 26.04.1. El nombre, los platos y los precios son ficticios y están señalados como demostración en la propia web.

## Estructura

- `public/index.html`: contenido y navegación semántica en español.
- `public/styles.css`: diseño adaptable sin frameworks ni fuentes externas.
- `public/assets/hero.webp`: fotografía optimizada; `favicon.svg`: icono local.
- `nginx.conf`: sitio Nginx con `try_files`, sin listado de directorios y con cabeceras básicas.
- `deploy-vm.sh`: activa la configuración Nginx para servir `public/` desde el clon.
- `install-cloudflared-vm.sh`: repositorio oficial firmado e instalación de Cloudflare Tunnel.
- `docs/`: capturas de comprobación y QR de prueba.

## Publicación local en la VM

Primero se crea el repositorio en GitHub. En la VM, después de instalar Git y Nginx, se clona en `/srv/casa-oliva`. Nginx sirve únicamente `public/`, por lo que `.git`, `README.md` y los scripts quedan fuera de la raíz web.

```bash
sudo apt update
sudo apt install git nginx
sudo install -d -o "$USER" -g "$USER" /srv/casa-oliva
git clone https://github.com/sulbaranjc/casa-oliva-carta.git /srv/casa-oliva
sudo bash /srv/casa-oliva/deploy-vm.sh
curl -I http://127.0.0.1/
```

Para publicar cambios posteriores:

```bash
git -C /srv/casa-oliva pull --ff-only
sudo nginx -t
```

Si cambia `nginx.conf`, ejecutar de nuevo `sudo bash /srv/casa-oliva/deploy-vm.sh`. El sitio se comprobó desde la laptop en `http://192.168.122.246/` (IP de DHCP de esta sesión), en escritorio de 1440 px y móvil de 390 px. La página sirve 14 platos de muestra y no presenta desplazamiento horizontal en móvil.

## Cloudflare

`cloudflared` 2026.10.0 se instaló desde el repositorio APT oficial firmado. El túnel rápido de prueba usa:

```bash
cloudflared tunnel --url http://127.0.0.1:80 --no-autoupdate
```

La URL `trycloudflare.com` y su QR dejan de ser válidos cuando termina el proceso y cambian al crear otro túnel. Para una tarjeta de mesa permanente, hay que publicar un túnel con nombre y un dominio administrado en Cloudflare, ejecutar el conector como servicio y regenerar el QR con esa URL. No se debe imprimir la tarjeta de prueba como material definitivo.

## Cambios para un restaurante real

Sustituir nombre, platos, precios, fotografía y aviso de alérgenos por información revisada por el restaurante antes de usar el QR con clientes.
