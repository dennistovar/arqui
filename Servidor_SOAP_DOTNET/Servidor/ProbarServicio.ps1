# Script de Prueba del Servicio WCF
# No requiere permisos de administrador

Write-Host "=== Pruebas del Servicio WCF - SOLO RED ===" -ForegroundColor Green
Write-Host "IP: 192.168.137.1 | Puerto: 63393" -ForegroundColor Cyan
Write-Host ""

$urls = @(
    "http://192.168.137.1:63393/Service.svc",
    "http://192.168.137.1:63393/Service.svc?wsdl"
)

# Función para probar conectividad
function Test-ServiceUrl {
    param(
        [string]$url
    )
    
    Write-Host "Probando: $url" -ForegroundColor Cyan
    try {
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 10 -ErrorAction Stop
        if ($response.StatusCode -eq 200) {
            Write-Host "  ? OK - Código de estado: $($response.StatusCode)" -ForegroundColor Green
            if ($url -like "*?wsdl*") {
                if ($response.Content -like "*wsdl:definitions*") {
                    Write-Host "  ? WSDL válido encontrado" -ForegroundColor Green
                }
            }
            return $true
        }
    } catch {
        Write-Host "  ? ERROR: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Verificar que el proceso esté escuchando en el puerto 63393
Write-Host "1. Verificando que el puerto 63393 está en uso..." -ForegroundColor Yellow
$port63393 = Get-NetTCPConnection -LocalPort 63393 -ErrorAction SilentlyContinue
if ($port63393) {
    Write-Host "   ? Puerto 63393 está en uso" -ForegroundColor Green
    $processName = Get-Process -Id $port63393[0].OwningProcess -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name
    Write-Host "   Proceso: $processName (PID: $($port63393[0].OwningProcess))" -ForegroundColor White
    
    # Verificar en qué IP está escuchando
    $bindings = $port63393 | Select-Object LocalAddress -Unique
    Write-Host "   Escuchando en:" -ForegroundColor White
    foreach ($binding in $bindings) {
        Write-Host "     - $($binding.LocalAddress):63393" -ForegroundColor Gray
    }
} else {
    Write-Host "   ? ADVERTENCIA: Puerto 63393 no está en uso" -ForegroundColor Yellow
    Write-Host "   Asegúrate de que el servicio esté ejecutándose en Visual Studio (F5)" -ForegroundColor Yellow
}

Write-Host ""

# Verificar la IP 192.168.137.1
Write-Host "2. Verificando IP 192.168.137.1..." -ForegroundColor Yellow
$ip = Get-NetIPAddress | Where-Object {$_.IPAddress -eq "192.168.137.1"}
if ($ip) {
    Write-Host "   ? IP 192.168.137.1 encontrada en adaptador: $($ip.InterfaceAlias)" -ForegroundColor Green
    Write-Host "   Estado: $($ip.PrefixOrigin)" -ForegroundColor White
} else {
    Write-Host "   ? ERROR: IP 192.168.137.1 NO encontrada en el sistema" -ForegroundColor Red
    Write-Host ""
    Write-Host "   Necesitas configurar esta IP en tu adaptador de red." -ForegroundColor Yellow
    Write-Host "   IPs disponibles actualmente:" -ForegroundColor Cyan
    Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.IPAddress -notlike "127.*"} | 
        Format-Table IPAddress, InterfaceAlias, PrefixOrigin -AutoSize
    Write-Host ""
    Write-Host "   Consulta el archivo RESUMEN_PRUEBAS.md para instrucciones de configuración." -ForegroundColor Yellow
}

Write-Host ""

# Probar cada URL
Write-Host "3. Probando conectividad a los endpoints..." -ForegroundColor Yellow
Write-Host ""

$results = @{}
foreach ($url in $urls) {
    $results[$url] = Test-ServiceUrl -url $url
    Start-Sleep -Milliseconds 500
    Write-Host ""
}

# Resumen
Write-Host "=== RESUMEN DE PRUEBAS ===" -ForegroundColor Green
Write-Host ""

$success = ($results.Values | Where-Object {$_ -eq $true}).Count
$total = $results.Count

Write-Host "Pruebas exitosas: $success de $total" -ForegroundColor $(if ($success -eq $total) {"Green"} elseif ($success -gt 0) {"Yellow"} else {"Red"})
Write-Host ""

# Mostrar resultados detallados
foreach ($url in $results.Keys) {
    $status = if ($results[$url]) {"? PASS"} else {"? FAIL"}
    $color = if ($results[$url]) {"Green"} else {"Red"}
    Write-Host "$status - $url" -ForegroundColor $color
}

Write-Host ""

if ($success -eq $total) {
    Write-Host "? ¡EXCELENTE! Todas las pruebas pasaron exitosamente." -ForegroundColor Green
    Write-Host "  El servicio está funcionando correctamente en la red 192.168.137.1:63393" -ForegroundColor Green
} elseif ($success -gt 0) {
    Write-Host "? PARCIAL: Algunas pruebas fallaron." -ForegroundColor Yellow
    Write-Host "  Revisa la configuración del firewall y las URLs reservadas." -ForegroundColor Yellow
} else {
    Write-Host "? ERROR: Todas las pruebas fallaron." -ForegroundColor Red
    Write-Host ""
    Write-Host "Verifica que:" -ForegroundColor White
    Write-Host "  1. La IP 192.168.137.1 esté configurada en tu adaptador de red" -ForegroundColor White
    Write-Host "  2. El servicio esté ejecutándose en Visual Studio (F5)" -ForegroundColor White
    Write-Host "  3. Visual Studio esté ejecutándose como Administrador" -ForegroundColor White
    Write-Host "  4. Hayas ejecutado ConfigurarServicio.bat como administrador" -ForegroundColor White
    Write-Host "  5. El firewall esté configurado correctamente" -ForegroundColor White
}

Write-Host ""
Write-Host "=== PRUEBAS FUNCIONALES DE LOS MÉTODOS ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Si las pruebas de conectividad pasaron, ejecuta:" -ForegroundColor White
Write-Host "  PruebasFuncionales.bat" -ForegroundColor Yellow
Write-Host ""

Write-Host "Presiona cualquier tecla para salir..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
