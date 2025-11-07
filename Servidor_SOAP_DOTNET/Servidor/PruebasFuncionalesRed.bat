@echo off
echo ========================================
echo   Pruebas Funcionales - Servicio WCF
echo ========================================
echo.
pause

PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0PruebasFuncionalesRed.ps1'"

pause
