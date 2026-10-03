[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^sql/queries/[A-Za-z0-9_.-]+\.sql$')]
    [string]$QueryFile
)

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot

Push-Location $projectRoot
try {
    if (-not (Test-Path -LiteralPath $QueryFile -PathType Leaf)) {
        throw "Query file not found: $QueryFile"
    }

    Get-Content -LiteralPath $QueryFile -Raw |
        docker compose exec -T postgres psql -U telemetry -d telemetry_lab -v ON_ERROR_STOP=1 -f /dev/stdin
    if ($LASTEXITCODE -ne 0) {
        throw "Query failed: $QueryFile"
    }
}
finally {
    Pop-Location
}

