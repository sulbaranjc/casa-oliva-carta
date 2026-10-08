# Casa Oliva · carta web de demostración

Sitio estático de una sola página para el taller de Ubuntu Server 26.04.1. El nombre, los platos y los precios son ficticios y están señalados como demostración en la propia web.

## Estructura

- `index.html`: contenido y navegación semántica en español.
- `styles.css`: diseño adaptable sin frameworks ni fuentes externas.
- `assets/hero.webp`: fotografía optimizada; `favicon.svg`: icono local.
- `nginx.conf`: sitio Nginx con `try_files`, sin listado de directorios y con cabeceras básicas.
- `deploy-vm.sh`: instalación de archivos y configuración Nginx en la VM.
- `install-cloudflared-vm.sh`: repositorio oficial firmado e instalación de Cloudflare Tunnel.
- `docs/`: capturas de comprobación y QR de prueba.

## Publicación local en la VM

En la VM, después de instalar Nginx, copiar `casa-oliva-site.tar.gz` a `/tmp` y ejecutar `deploy-vm.sh` con `sudo`. El script publica la web en `/var/www/casa-oliva`, comprueba `nginx -t` y recarga el servicio.

```bash
sudo apt update
sudo apt install nginx
sudo bash /tmp/deploy-casa-oliva.sh
curl -I http://127.0.0.1/
```

El sitio se comprobó desde la laptop en `http://192.168.122.246/` (IP de DHCP de esta sesión), en escritorio de 1440 px y móvil de 390 px. La página sirve 14 platos de muestra y no presenta desplazamiento horizontal en móvil.

## Cloudflare

`cloudflared` 2026.10.0 se instaló desde el repositorio APT oficial firmado. El túnel rápido de prueba usa:

```bash
cloudflared tunnel --url http://127.0.0.1:80 --no-autoupdate
```

La URL `trycloudflare.com` y su QR dejan de ser válidos cuando termina el proceso y cambian al crear otro túnel. Para una tarjeta de mesa permanente, hay que publicar un túnel con nombre y un dominio administrado en Cloudflare, ejecutar el conector como servicio y regenerar el QR con esa URL. No se debe imprimir la tarjeta de prueba como material definitivo.

## Cambios para un restaurante real

Sustituir nombre, platos, precios, fotografía y aviso de alérgenos por información revisada por el restaurante antes de usar el QR con clientes.
