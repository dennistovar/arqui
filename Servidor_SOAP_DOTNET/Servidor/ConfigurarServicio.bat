@echo off
echo ========================================
echo    Configuracion del Servicio WCF
echo ========================================
echo.
echo Este script configurara el firewall y las URLs
echo para permitir el acceso al servicio desde la red.
echo.
echo IMPORTANTE: Este script requiere permisos de administrador
echo.
pause

PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0ConfigurarServicio.ps1'"

pause
