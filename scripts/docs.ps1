# Builds the docs of every imping crate into one site at target/doc.
#
# Usage, from the repo root: powershell -ExecutionPolicy Bypass -File scripts/docs.ps1 [-Open]

param([switch]$Open)

$ErrorActionPreference = 'Stop'
Set-Location (Split-Path -Parent $PSScriptRoot)

# One target dir for all of them, so they land in one site and link to each other.
$env:CARGO_TARGET_DIR = Join-Path (Get-Location) 'target'

$builds = [ordered]@{
    'imping-hook'    = @()
    'imping-ir'      = @()
    'imping-runtime' = @()
    # --lib keeps the CLI binary out; the fixture is tests only.
    'imping-codegen' = @('--lib', '--workspace', '--exclude', 'codegen-fixture')
}
foreach ($repo in $builds.Keys) {
    Push-Location $repo
    cargo doc --no-deps --all-features @($builds[$repo])
    $failed = $LASTEXITCODE
    Pop-Location
    if ($failed) { exit $failed }
}

Copy-Item docs/index.html target/doc/index.html
if ($Open) { Start-Process target/doc/index.html }
