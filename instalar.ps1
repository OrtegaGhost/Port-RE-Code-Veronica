<#
  Instalador de "Resident Evil Code Veronica" (PS2 -> PC, via PCSX2 portable).
  Uso (PowerShell):
    .\instalar.ps1 -Iso "C:\ruta\juego.iso" -Bios "C:\ruta\scph39001.bin" [-Portada "C:\ruta\cover.png"] [-Destino "$HOME\Desktop\RE Code Veronica"]
  Crea la carpeta del juego, descarga PCSX2, aplica la configuracion de config\PCSX2.ini
  y deja un icono en el escritorio que abre el juego con doble clic.
#>
param(
    [Parameter(Mandatory)][string]$Iso,
    [Parameter(Mandatory)][string]$Bios,
    [string]$Portada,
    [string]$Destino = "$HOME\Desktop\RE Code Veronica"
)
$ErrorActionPreference = 'Stop'
$repo = $PSScriptRoot

foreach ($p in $Iso, $Bios) { if (-not (Test-Path -LiteralPath $p)) { throw "No existe: $p" } }
$sevenZip = "C:\Program Files\7-Zip\7z.exe"
if (-not (Test-Path $sevenZip)) { throw "Falta 7-Zip (winget install 7zip.7zip)" }

$emu = Join-Path $Destino 'emulador'
$juego = Join-Path $Destino 'juego'
New-Item -ItemType Directory -Force $emu, $juego, "$emu\bios", "$emu\inis" | Out-Null

# 1. PCSX2 (ultima version para Windows x64)
Write-Host "Descargando PCSX2..."
$rel = Invoke-RestMethod "https://api.github.com/repos/PCSX2/pcsx2/releases?per_page=1" | Select-Object -First 1
$asset = $rel.assets | Where-Object { $_.name -match 'windows-x64-Qt\.7z$' } | Select-Object -First 1
$tmp = Join-Path $env:TEMP $asset.name
Invoke-WebRequest $asset.browser_download_url -OutFile $tmp
& $sevenZip x -y "-o$emu" $tmp | Out-Null
Remove-Item $tmp
New-Item -ItemType File -Force "$emu\portable.txt" | Out-Null   # modo portable

# 2. BIOS e ISO (los aportas tu; no estan en este repo)
$biosName = Split-Path $Bios -Leaf
Copy-Item -LiteralPath $Bios "$emu\bios\$biosName"
foreach ($ext in 'MEC', 'NVM') {
    $extra = [IO.Path]::ChangeExtension($Bios, $ext)
    if (Test-Path -LiteralPath $extra) { Copy-Item -LiteralPath $extra "$emu\bios" }
}
Copy-Item -LiteralPath $Iso "$juego\RECVX.iso"

# 3. Configuracion (1080p+, widescreen, VSync, pantalla completa)
(Get-Content "$repo\config\PCSX2.ini" -Raw) -replace 'scph39001\.bin', $biosName |
    Set-Content "$emu\inis\PCSX2.ini" -Encoding ASCII

# 4. Icono: portada del juego (opcional)
$icono = $null
if ($Portada -and (Test-Path -LiteralPath $Portada)) {
    Add-Type -AssemblyName System.Drawing
    $img = [Drawing.Image]::FromFile($Portada)
    $bmp = New-Object Drawing.Bitmap 256, 256
    $g = [Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = 'HighQualityBicubic'
    $s = [math]::Min(256 / $img.Width, 256 / $img.Height)
    $w = [int]($img.Width * $s); $h = [int]($img.Height * $s)
    $g.DrawImage($img, [int]((256 - $w) / 2), [int]((256 - $h) / 2), $w, $h)
    $g.Dispose(); $img.Dispose()
    $ms = New-Object IO.MemoryStream
    $bmp.Save($ms, [Drawing.Imaging.ImageFormat]::Png); $png = $ms.ToArray(); $bmp.Dispose()
    $icono = "$juego\icono.ico"
    $bw = New-Object IO.BinaryWriter([IO.File]::Create($icono))
    $bw.Write([uint16]0); $bw.Write([uint16]1); $bw.Write([uint16]1)
    $bw.Write([byte]0); $bw.Write([byte]0); $bw.Write([byte]0); $bw.Write([byte]0)
    $bw.Write([uint16]1); $bw.Write([uint16]32); $bw.Write([uint32]$png.Length); $bw.Write([uint32]22)
    $bw.Write($png); $bw.Close()
}

# 5. Acceso directo en el escritorio
$lnk = (New-Object -ComObject WScript.Shell).CreateShortcut("$HOME\Desktop\Resident Evil Code Veronica.lnk")
$lnk.TargetPath = "$emu\pcsx2-qt.exe"
$lnk.Arguments = "-batch -fullscreen -- `"$juego\RECVX.iso`""
$lnk.WorkingDirectory = $emu
if ($icono) { $lnk.IconLocation = $icono }
$lnk.Save()

Write-Host "Listo. Doble clic en 'Resident Evil Code Veronica' en el escritorio."
