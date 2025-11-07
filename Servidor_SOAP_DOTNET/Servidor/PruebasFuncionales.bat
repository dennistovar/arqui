@echo off
echo ========================================
echo   Pruebas Funcionales del Servicio WCF
echo ========================================
echo.
echo Este script probara todos los metodos de conversion
echo del servicio WCF.
echo.
echo NOTA: Asegurate de que el servicio este ejecutandose
echo en Visual Studio antes de continuar.
echo.
pause

PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0PruebasFuncionales.ps1'"

pause
