Write-Host "=============================================="
Write-Host "     Xianyu Auto Reply System - Quick Stop"
Write-Host "=============================================="
Write-Host ""
Write-Host "Stopping all services..."
Write-Host ""

$basePath = $PSScriptRoot

Write-Host "[STOP] Backend-Web Service (Port: 8089)..."
Stop-Process -Name "python" -ErrorAction SilentlyContinue
Stop-Process -Name "node" -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "=============================================="
Write-Host "         All services have been stopped"
Write-Host "=============================================="
Write-Host ""
Read-Host "Press Enter to close this window"