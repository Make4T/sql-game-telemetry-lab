[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot

Push-Location $projectRoot
try {
    docker compose up -d
    $sqlFiles = @(
        'sql/schema/001_initial.sql',
        'sql/schema/002_indexes.sql',
        'sql/seed/001_sample_data.sql'
    )

    foreach ($sqlFile in $sqlFiles) {
        Get-Content -LiteralPath $sqlFile -Raw |
            docker compose exec -T postgres psql -U telemetry -d telemetry_lab -v ON_ERROR_STOP=1 -f /dev/stdin
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to apply $sqlFile"
        }
    }

    Get-Content -LiteralPath 'tests/smoke.sql' -Raw |
        docker compose exec -T postgres psql -U telemetry -d telemetry_lab -v ON_ERROR_STOP=1 -f /dev/stdin
    if ($LASTEXITCODE -ne 0) {
        throw 'Smoke test failed'
    }

    Write-Host 'Database is ready and smoke test passed.' -ForegroundColor Green
}
finally {
    Pop-Location
}

