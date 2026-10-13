@echo off
setlocal
cd /d "%~dp0"

if not exist ".venv\Scripts\mpf.exe" (
    echo ERROR: MPF was not found in "%CD%\.venv".
    echo Put this batch file in the ASM67 folder that contains .venv.
    pause
    exit /b 1
)

start "ASM67 - MPF Monitor" powershell.exe -NoExit -ExecutionPolicy Bypass -Command "Set-Location -LiteralPath '%CD%'; & '.\.venv\Scripts\Activate.ps1'; mpf monitor"
start "ASM67 - MPF Virtual" powershell.exe -NoExit -ExecutionPolicy Bypass -Command "Set-Location -LiteralPath '%CD%'; & '.\.venv\Scripts\Activate.ps1'; mpf -Xt"

endlocal
