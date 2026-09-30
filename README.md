# Resident Evil Code Veronica X (PS2) en PC

Juego de PS2 (version remasterizada con texturas HD, NTSC) empaquetado para PC: un icono en el escritorio, doble clic y se abre a pantalla completa. Por dentro corre sobre **PCSX2** (emulador) en modo portable; no es un port nativo.

> Uso privado. Este repo **no contiene** el juego, la BIOS ni ninguna imagen de disco. Necesitas tu propia copia.

## Que hace el instalador
1. Descarga la ultima version de PCSX2 (Windows x64) y la deja en modo portable.
2. Copia tu BIOS y tu ISO a la carpeta del juego.
3. Aplica `config/PCSX2.ini`: Direct3D 12, escala 3x (~1920x1344), 16:9 con parche widescreen, sin entrelazado, anisotropico 16x, VSync, pantalla completa.
4. Crea el icono del escritorio (con la portada, si la das) que lanza `pcsx2-qt.exe -batch -fullscreen -- RECVX.iso`.

## Requisitos
- Windows 10/11 x64, GPU con Direct3D 12 (probado en GTX 1650, i5-10300H, 24 GB RAM).
- [7-Zip](https://www.7-zip.org/) (`winget install 7zip.7zip`).
- Tu ISO del juego (NTSC, serie SLUS-20185).
- Tu BIOS de PS2 **NTSC-U** (probado con `scph39001.bin`). Las PAL no corresponden a un juego NTSC. Sacala de una consola PS2 tuya.

## Instalacion
```powershell
git clone https://github.com/OrtegaGhost/Port-RE-Code-Veronica.git
cd Port-RE-Code-Veronica
.\instalar.ps1 -Iso "C:\ruta\RE CVX REMASTERED v2.1.iso" -Bios "C:\ruta\scph39001.bin" -Portada "C:\ruta\cover.png"
```
Si PowerShell bloquea el script: `powershell -ExecutionPolicy Bypass -File .\instalar.ps1 ...`

Por defecto se instala en `Escritorio\RE Code Veronica`; cambialo con `-Destino`.

## Uso
- Doble clic en **Resident Evil Code Veronica** del escritorio.
- `Alt+Enter` o `F11`: pantalla completa / ventana. `Esc` o `Alt+F4`: salir.
- Guardados en `emulador\memcards`; estados rapidos en `emulador\sstates`. Respaldalos antes de reinstalar.

## Ajustes si va justo de rendimiento
Edita `emulador\inis\PCSX2.ini` (con el juego cerrado):
- `upscale_multiplier = 2` (mas fluido) o `4` (mas nitido).
- `MaxAnisotropy = 8`.

## Pasos que se siguieron (historial)
1. Se evaluo `psxrestore/VeronicaRecomp` (recompilacion nativa): resulto ser de la version **Xbox 360** (`default.xex`), no PS2, asi que se descarto.
2. Proyectos de PS2 revisados: `recvx-decomp` (descompilacion de la version PS2, aun no genera ejecutable de PC) y `PS2Recomp` (experimental). Un port nativo real de PS2 queda como proyecto futuro.
3. Se opto por PCSX2 portable + ISO remasterizada con texturas HD + BIOS NTSC-U, empaquetado con icono de escritorio.
4. Nota: la linea `Bios = bios` de `[Folders]` debe apuntar a la carpeta; `BIOS = archivo.bin` de `[Filenames]` al archivo. Confundirlas hace que PCSX2 no encuentre la BIOS.

## Pendiente
- Medir fps reales en la laptop.
- Pruebas de mando y teclado.
- Port nativo (PS2Recomp / recvx-decomp), si se quiere.
