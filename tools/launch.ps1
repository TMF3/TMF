<#
.SYNOPSIS
    Builds TMF with HEMTT and launches Arma 3 with TMF, CBA_A3 and ACRE2.

.EXAMPLE
    .\tools\launch.ps1
    .\tools\launch.ps1 -NoBuild
    .\tools\launch.ps1 -ArmaDir "D:\Steam\steamapps\common\Arma 3" -ExtraArgs "-world=Stratis"
#>
param(
    # Arma 3 install folder (the one containing arma3_x64.exe and !Workshop)
    [string]$ArmaDir = "F:\Games\steamapps\common\Arma 3",
    # Skip `hemtt build` and launch with the last build in .hemttout\build
    [switch]$NoBuild,
    # Extra Arma 3 startup parameters
    [string]$ExtraArgs = ""
)

$ErrorActionPreference = "Stop"
$repo = Split-Path -Parent $PSScriptRoot
$workshop = Join-Path $ArmaDir "!Workshop"
$exe = Join-Path $ArmaDir "arma3_x64.exe"

if (-not (Test-Path $exe)) { throw "Arma 3 not found: $exe" }

if (-not $NoBuild) {
    Push-Location $repo
    try {
        hemtt build
        if ($LASTEXITCODE -ne 0) { throw "hemtt build failed (exit $LASTEXITCODE)" }
    } finally {
        Pop-Location
    }
}

$mods = @(
    (Join-Path $workshop "@CBA_A3"),
    (Join-Path $workshop "@ACRE2"),
    (Join-Path $repo ".hemttout\build")
)
foreach ($mod in $mods) {
    if (-not (Test-Path (Join-Path $mod "addons"))) { throw "Mod folder missing or not built: $mod" }
}

$arguments = @(
    "-mod=`"$($mods -join ';')`"",
    "-skipIntro",
    "-noSplash",
    "-showScriptErrors",
    "-debug"
)
if ($ExtraArgs) { $arguments += $ExtraArgs }

Write-Host "Launching Arma 3 with:"
$mods | ForEach-Object { Write-Host "  $_" }
Start-Process -FilePath $exe -ArgumentList $arguments -WorkingDirectory $ArmaDir
