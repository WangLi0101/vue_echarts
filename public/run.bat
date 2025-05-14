@echo off
echo Starting LiveKit server...

:: 检查 serve 是否已安装
where serve >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Installing serve...
    call npm install -g serve
) else (
    echo serve is already installed.
)

echo Starting backend server...
start "Backend Server" cmd /c "serve ."

pause
