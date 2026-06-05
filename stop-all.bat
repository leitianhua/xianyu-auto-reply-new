@echo off
chcp 65001 >nul
echo ==============================================
echo     Xianyu Auto Reply System - Quick Stop
echo ==============================================
echo.
echo Stopping all services...
echo.

echo [STOP] Stopping Python processes...
taskkill /f /im python.exe >nul 2>&1

echo [STOP] Stopping Node.js processes...
taskkill /f /im node.exe >nul 2>&1

echo.
echo ==============================================
echo         All services have been stopped
echo ==============================================
echo.
pause