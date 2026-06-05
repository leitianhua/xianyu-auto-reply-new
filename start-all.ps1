Write-Host "=============================================="
Write-Host "     Xianyu Auto Reply System - Quick Start"
Write-Host "=============================================="
Write-Host ""
Write-Host "Loading environment variables..."
Write-Host ""

$basePath = $PSScriptRoot
$envFile = Join-Path $basePath ".env"

if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        if ($_ -match '^([^#=]+)=(.+)$') {
            $name = $matches[1].Trim()
            $value = $matches[2].Trim()
            [Environment]::SetEnvironmentVariable($name, $value, 'Process')
            Write-Host "  Loaded: $name=$value"
        }
    }
    Write-Host ""
}

Write-Host "Starting services..."
Write-Host ""

$pythonPath = (Get-Command python).Source

Write-Host "[START] Backend-Web Service..."
Start-Process -FilePath $pythonPath -ArgumentList "main.py" -WorkingDirectory (Join-Path $basePath "backend-web")

Write-Host "[WAIT] Waiting for backend service..."
Start-Sleep -Seconds 8

Write-Host ""
Write-Host "[START] WebSocket Service..."
Start-Process -FilePath $pythonPath -ArgumentList "main.py" -WorkingDirectory (Join-Path $basePath "websocket")

Write-Host "[WAIT] Waiting for WebSocket service..."
Start-Sleep -Seconds 3

Write-Host ""
Write-Host "[START] Scheduler Service..."
Start-Process -FilePath $pythonPath -ArgumentList "main.py" -WorkingDirectory (Join-Path $basePath "scheduler")

Write-Host "[WAIT] Waiting for scheduler service..."
Start-Sleep -Seconds 3

Write-Host ""
Write-Host "[START] Frontend Service..."
Start-Process -FilePath "npm" -ArgumentList "run dev" -WorkingDirectory (Join-Path $basePath "frontend")

Write-Host ""
Write-Host "=============================================="
Write-Host "       All services have been started"
Write-Host "=============================================="
Write-Host ""
Write-Host "Service Status:"
Write-Host "  - Backend-Web: http://localhost:8089"
Write-Host "  - WebSocket: http://localhost:8090"
Write-Host "  - Scheduler: http://localhost:8091"
Write-Host "  - Frontend: http://localhost:9000"
Write-Host ""
Write-Host "After all services are ready, visit: http://localhost:9000"
Write-Host ""
Read-Host "Press Enter to close this window"