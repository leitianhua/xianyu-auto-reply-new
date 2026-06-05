@echo off
chcp 65001 >nul
echo ==============================================
echo     Xianyu Auto Reply System - Quick Start
echo ==============================================
echo.
echo Loading environment variables...
echo.

set "BASE_DIR=%~dp0"

for /f "tokens=1,2 delims==" %%a in (%BASE_DIR%.env) do (
    if not "%%a"=="" if not "%%a:~0,1"=="#" (
        set "%%a=%%b"
        echo   Loaded: %%a=%%b
    )
)

echo.
echo Starting services...
echo.

echo [START] Backend-Web Service...
start "Backend-Web" cmd /k "cd /d %BASE_DIR%backend-web && set MYSQL_HOST=%MYSQL_HOST% && set MYSQL_PORT=%MYSQL_PORT% && set MYSQL_USER=%MYSQL_USER% && set MYSQL_PASSWORD=%MYSQL_PASSWORD% && set MYSQL_DATABASE=%MYSQL_DATABASE% && set REDIS_HOST=%REDIS_HOST% && set REDIS_PORT=%REDIS_PORT% && set REDIS_PASSWORD=%REDIS_PASSWORD% && python main.py"

echo [WAIT] Waiting 8 seconds...
timeout /t 8 /nobreak >nul

echo.
echo [START] WebSocket Service...
start "WebSocket" cmd /k "cd /d %BASE_DIR%websocket && set MYSQL_HOST=%MYSQL_HOST% && set MYSQL_PORT=%MYSQL_PORT% && set MYSQL_USER=%MYSQL_USER% && set MYSQL_PASSWORD=%MYSQL_PASSWORD% && set MYSQL_DATABASE=%MYSQL_DATABASE% && set REDIS_HOST=%REDIS_HOST% && set REDIS_PORT=%REDIS_PORT% && set REDIS_PASSWORD=%REDIS_PASSWORD% && python main.py"

echo [WAIT] Waiting 3 seconds...
timeout /t 3 /nobreak >nul

echo.
echo [START] Scheduler Service...
start "Scheduler" cmd /k "cd /d %BASE_DIR%scheduler && set MYSQL_HOST=%MYSQL_HOST% && set MYSQL_PORT=%MYSQL_PORT% && set MYSQL_USER=%MYSQL_USER% && set MYSQL_PASSWORD=%MYSQL_PASSWORD% && set MYSQL_DATABASE=%MYSQL_DATABASE% && set REDIS_HOST=%REDIS_HOST% && set REDIS_PORT=%REDIS_PORT% && set REDIS_PASSWORD=%REDIS_PASSWORD% && python main.py"

echo [WAIT] Waiting 3 seconds...
timeout /t 3 /nobreak >nul

echo.
echo [START] Frontend Service...
start "Frontend" cmd /k "cd /d %BASE_DIR%frontend && npm run dev"

echo.
echo ==============================================
echo       All services have been started
echo ==============================================
echo.
echo Service Status:
echo   - Backend-Web: http://localhost:8089
echo   - WebSocket: http://localhost:8090
echo   - Scheduler: http://localhost:8091
echo   - Frontend: http://localhost:9000
echo.
echo After all services are ready, visit: http://localhost:9000
echo.
echo To stop all services, run: stop-all.bat
echo.
pause