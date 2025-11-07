@echo off
echo ========================================
echo   Probar Servicio WCF en Red
echo ========================================
echo.
echo Este script detectara automaticamente tu IP
echo y probara la conectividad del servicio.
echo.
pause

PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0ProbarServicioRed.ps1'"

pause
