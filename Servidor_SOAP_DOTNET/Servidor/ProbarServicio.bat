@echo off
echo ========================================
echo      Pruebas del Servicio WCF
echo ========================================
echo.
echo Este script probara la conectividad al servicio
echo.
echo NOTA: Asegurate de que el servicio este ejecutandose
echo en Visual Studio (presiona F5) antes de continuar.
echo.
pause

PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0ProbarServicio.ps1'"

pause
