@echo off
echo ========================================
echo   EJECUTAR APP ANDROID - MONSTER UNIVERSITY
echo ========================================
echo.

echo [1/3] Verificando servidor Java...
curl -s http://localhost:8080/WS_ConersionUnidades_RESTFULL/webresources/application.wadl > nul
if %errorlevel% equ 0 (
    echo ✓ Servidor Java activo
) else (
    echo ✗ ERROR: Servidor Java no esta corriendo
    echo   Inicia el servidor primero desde NetBeans/IntelliJ
    pause
    exit /b 1
)

echo.
echo [2/3] Limpiando proyecto...
call gradlew.bat clean

echo.
echo [3/3] Compilando e instalando en el dispositivo...
call gradlew.bat installDebug

echo.
echo ========================================
echo   Instalacion completada
echo ========================================
echo.
echo IMPORTANTE:
echo - Si usas EMULADOR: La app usa http://10.0.2.2:8080
echo - Si usas DISPOSITIVO FISICO: Cambia a http://192.168.18.113:8080
echo   en ApiConfig.java
echo.
pause
