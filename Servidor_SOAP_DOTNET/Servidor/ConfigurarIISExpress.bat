@echo off
echo ========================================
echo  Configurar IIS Express para Red
echo ========================================
echo.
echo Este script configurara IIS Express para
echo permitir acceso desde la red.
echo.
echo IMPORTANTE: Requiere permisos de administrador
echo.
pause

PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0ConfigurarIISExpress.ps1'"

pause
