# Script de Prueba del Servicio WCF - Detección Automática de IP
# No requiere permisos de administrador

Write-Host "=== Pruebas del Servicio WCF - Detección Automática ===" -ForegroundColor Green
Write-Host ""

$puerto = "63393"

# Detectar IP local
Write-Host "1. Detectando configuración de red..." -ForegroundColor Yellow
$localIP = Get-NetIPAddress -AddressFamily IPv4 | 
    Where-Object {$_.IPAddress -notlike "127.*" -and $_.IPAddress -notlike "169.254.*"} | 
    Select-Object -First 1

if ($localIP) {
    $ip = $localIP.IPAddress
    $adaptador = $localIP.InterfaceAlias
    Write-Host "   ? IP encontrada: $ip (Adaptador: $adaptador)" -ForegroundColor Green
} else {
    Write-Host "   ? No se detectó IP de red" -ForegroundColor Yellow
    $ip = "192.168.137.1"
    Write-Host "   Usando IP por defecto: $ip" -ForegroundColor White
}

Write-Host ""

# URLs a probar
$urls = @(
    "http://localhost:$puerto/Service.svc",
    "http://${ip}:$puerto/Service.svc",
    "http://localhost:$puerto/Service.svc?wsdl",
    "http://${ip}:$puerto/Service.svc?wsdl"
)

# Función para probar conectividad
function Test-ServiceUrl {
    param([string]$url)
    
    Write-Host "Probando: $url" -ForegroundColor Cyan
    try {
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 5 -ErrorAction Stop
        if ($response.StatusCode -eq 200) {
            Write-Host "  ? OK - Status: $($response.StatusCode)" -ForegroundColor Green
            if ($url -like "*?wsdl*" -and $response.Content -like "*wsdl:definitions*") {
                Write-Host "  ? WSDL válido" -ForegroundColor Green
            }
            return $true
        }
    } catch {
        $errorMsg = $_.Exception.Message
        if ($errorMsg -like "*ECONNREFUSED*" -or $errorMsg -like "*refused*") {
            Write-Host "  ? ERROR: Conexión rechazada - El servicio no está escuchando en esta dirección" -ForegroundColor Red
        } elseif ($errorMsg -like "*timeout*") {
            Write-Host "  ? ERROR: Timeout - No se pudo conectar" -ForegroundColor Red
        } else {
            Write-Host "  ? ERROR: $errorMsg" -ForegroundColor Red
        }
        return $false
    }
}

# Verificar puerto
Write-Host "2. Verificando que el puerto $puerto esté en uso..." -ForegroundColor Yellow
$connections = Get-NetTCPConnection -LocalPort $puerto -ErrorAction SilentlyContinue

if ($connections) {
    Write-Host "   ? Puerto $puerto está en uso" -ForegroundColor Green
    $process = Get-Process -Id $connections[0].OwningProcess -ErrorAction SilentlyContinue
    if ($process) {
        Write-Host "   Proceso: $($process.Name) (PID: $($process.Id))" -ForegroundColor White
    }
    
    Write-Host "   Direcciones en escucha:" -ForegroundColor White
    $connections | Select-Object LocalAddress -Unique | ForEach-Object {
        Write-Host "     - $($_.LocalAddress):$puerto" -ForegroundColor Gray
    }
} else {
    Write-Host "   ? Puerto $puerto NO está en uso" -ForegroundColor Red
    Write-Host "   El servicio no está ejecutándose" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "   SOLUCIÓN:" -ForegroundColor Cyan
    Write-Host "   1. Cierra Visual Studio" -ForegroundColor White
    Write-Host "   2. Ejecuta ConfigurarIISExpress.bat como administrador" -ForegroundColor White
    Write-Host "   3. Abre Visual Studio como administrador" -ForegroundColor White
    Write-Host "   4. Presiona F5 para ejecutar el servicio" -ForegroundColor White
    Write-Host ""
    Write-Host "Presiona cualquier tecla para salir..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

Write-Host ""

# Probar URLs
Write-Host "3. Probando conectividad..." -ForegroundColor Yellow
Write-Host ""

$results = @{}
foreach ($url in $urls) {
    $results[$url] = Test-ServiceUrl -url $url
    Start-Sleep -Milliseconds 300
    Write-Host ""
}

# Resumen
Write-Host "=== RESUMEN ===" -ForegroundColor Green
Write-Host ""

$success = ($results.Values | Where-Object {$_ -eq $true}).Count
$total = $results.Count

Write-Host "Pruebas exitosas: $success de $total" -ForegroundColor $(
    if ($success -eq $total) {"Green"} 
    elseif ($success -gt 0) {"Yellow"} 
    else {"Red"}
)
Write-Host ""

foreach ($url in $results.Keys) {
    $status = if ($results[$url]) {"?"} else {"?"}
    $color = if ($results[$url]) {"Green"} else {"Red"}
    Write-Host "$status $url" -ForegroundColor $color
}

Write-Host ""

if ($success -eq $total) {
    Write-Host "?? ¡PERFECTO! El servicio funciona correctamente" -ForegroundColor Green
    Write-Host ""
    Write-Host "Puedes acceder al servicio desde:" -ForegroundColor Cyan
    Write-Host "  • Esta computadora: http://localhost:$puerto/Service.svc" -ForegroundColor White
    Write-Host "  • Otras computadoras en la red: http://${ip}:$puerto/Service.svc" -ForegroundColor White
    Write-Host ""
    Write-Host "Para probar los métodos, ejecuta: PruebasFuncionalesRed.bat" -ForegroundColor Yellow
} elseif ($success -gt 0) {
    Write-Host "? Funciona parcialmente" -ForegroundColor Yellow
    Write-Host ""
    if ($results["http://localhost:$puerto/Service.svc"]) {
        Write-Host "El servicio funciona localmente pero NO desde la red" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "SOLUCIÓN:" -ForegroundColor Cyan
        Write-Host "1. Ejecuta ConfigurarIISExpress.bat como administrador" -ForegroundColor White
        Write-Host "2. Reinicia Visual Studio como administrador" -ForegroundColor White
        Write-Host "3. Ejecuta el servicio (F5)" -ForegroundColor White
    }
} else {
    Write-Host "? El servicio no responde" -ForegroundColor Red
    Write-Host ""
    Write-Host "POSIBLES CAUSAS:" -ForegroundColor Yellow
    Write-Host "1. El servicio no está ejecutándose" -ForegroundColor White
    Write-Host "2. Visual Studio no tiene permisos de administrador" -ForegroundColor White
    Write-Host "3. El firewall está bloqueando la conexión" -ForegroundColor White
    Write-Host "4. No se reservaron las URLs correctamente" -ForegroundColor White
    Write-Host ""
    Write-Host "SOLUCIÓN COMPLETA:" -ForegroundColor Cyan
    Write-Host "1. Cierra Visual Studio completamente" -ForegroundColor White
    Write-Host "2. Ejecuta ConfigurarIISExpress.bat como administrador" -ForegroundColor White
    Write-Host "3. Abre Visual Studio como administrador" -ForegroundColor White
    Write-Host "4. Presiona F5 para ejecutar el servicio" -ForegroundColor White
    Write-Host "5. Ejecuta este script nuevamente" -ForegroundColor White
}

Write-Host ""
Write-Host "Presiona cualquier tecla para salir..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
