# Script de Pruebas Funcionales - Detección Automática de IP

Write-Host "=== PRUEBAS FUNCIONALES DEL SERVICIO WCF ===" -ForegroundColor Green
Write-Host ""

$puerto = "63393"

# Detectar IP local
$localIP = Get-NetIPAddress -AddressFamily IPv4 | 
    Where-Object {$_.IPAddress -notlike "127.*" -and $_.IPAddress -notlike "169.254.*"} | 
    Select-Object -First 1

if ($localIP) {
    $ip = $localIP.IPAddress
    Write-Host "IP de red detectada: $ip" -ForegroundColor Cyan
} else {
    $ip = "localhost"
    Write-Host "No se detectó IP de red, usando localhost" -ForegroundColor Yellow
}

Write-Host ""

# Preguntar al usuario qué URL usar
Write-Host "¿Qué URL deseas usar para las pruebas?" -ForegroundColor Yellow
Write-Host "1. Localhost (http://localhost:$puerto/Service.svc)" -ForegroundColor White
Write-Host "2. Red (http://${ip}:$puerto/Service.svc)" -ForegroundColor White
Write-Host ""
$opcion = Read-Host "Opción (1 o 2, Enter = 1)"

if ($opcion -eq "2") {
    $serviceUrl = "http://${ip}:$puerto/Service.svc?wsdl"
    Write-Host "Usando URL de red: $serviceUrl" -ForegroundColor Cyan
} else {
    $serviceUrl = "http://localhost:$puerto/Service.svc?wsdl"
    Write-Host "Usando URL local: $serviceUrl" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Conectando al servicio..." -ForegroundColor Yellow
Write-Host ""

try {
    # Crear proxy del servicio
    $proxy = New-WebServiceProxy -Uri $serviceUrl -ErrorAction Stop
    Write-Host "? Conexión exitosa" -ForegroundColor Green
    Write-Host ""
    
    $errores = 0
    $exitosos = 0
    
    # TEMPERATURA
    Write-Host "=== TEMPERATURA ===" -ForegroundColor Magenta
    Write-Host ""
    
    try {
        Write-Host "Test: CelsiusToFahrenheit(25)" -ForegroundColor Cyan
        $resultado = $proxy.CelsiusToFahrenheit(25)
        if ([Math]::Abs($resultado - 77) -lt 0.1) {
            Write-Host "  ? PASS - 25°C = $resultado°F" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Esperado: 77, Obtenido: $resultado" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    try {
        Write-Host "Test: FahrenheitToCelsius(77)" -ForegroundColor Cyan
        $resultado = $proxy.FahrenheitToCelsius(77)
        if ([Math]::Abs($resultado - 25) -lt 0.1) {
            Write-Host "  ? PASS - 77°F = $resultado°C" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Esperado: 25, Obtenido: $resultado" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    try {
        Write-Host "Test: CelsiusToKelvin(0)" -ForegroundColor Cyan
        $resultado = $proxy.CelsiusToKelvin(0)
        if ([Math]::Abs($resultado - 273.15) -lt 0.1) {
            Write-Host "  ? PASS - 0°C = ${resultado}K" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Esperado: 273.15, Obtenido: $resultado" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    Write-Host ""
    
    # MASA
    Write-Host "=== MASA ===" -ForegroundColor Magenta
    Write-Host ""
    
    try {
        Write-Host "Test: KilogramsToPounds(10)" -ForegroundColor Cyan
        $resultado = $proxy.KilogramsToPounds(10)
        if ([Math]::Abs($resultado - 22.0462) -lt 0.1) {
            Write-Host "  ? PASS - 10kg = $resultado lb" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Esperado: 22.0462, Obtenido: $resultado" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    try {
        Write-Host "Test: PoundsToKilograms(22.0462)" -ForegroundColor Cyan
        $resultado = $proxy.PoundsToKilograms(22.0462)
        if ([Math]::Abs($resultado - 10) -lt 0.1) {
            Write-Host "  ? PASS - 22.0462lb = ${resultado}kg" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Esperado: 10, Obtenido: $resultado" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    try {
        Write-Host "Test: KilogramsToOunces(1)" -ForegroundColor Cyan
        $resultado = $proxy.KilogramsToOunces(1)
        if ([Math]::Abs($resultado - 35.274) -lt 0.1) {
            Write-Host "  ? PASS - 1kg = ${resultado}oz" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Esperado: 35.274, Obtenido: $resultado" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    Write-Host ""
    
    # LONGITUD
    Write-Host "=== LONGITUD ===" -ForegroundColor Magenta
    Write-Host ""
    
    try {
        Write-Host "Test: MetersToFeet(100)" -ForegroundColor Cyan
        $resultado = $proxy.MetersToFeet(100)
        if ([Math]::Abs($resultado - 328.084) -lt 0.1) {
            Write-Host "  ? PASS - 100m = ${resultado}ft" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Esperado: 328.084, Obtenido: $resultado" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    try {
        Write-Host "Test: FeetToMeters(328.084)" -ForegroundColor Cyan
        $resultado = $proxy.FeetToMeters(328.084)
        if ([Math]::Abs($resultado - 100) -lt 0.1) {
            Write-Host "  ? PASS - 328.084ft = ${resultado}m" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Esperado: 100, Obtenido: $resultado" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    try {
        Write-Host "Test: KilometersToMiles(10)" -ForegroundColor Cyan
        $resultado = $proxy.KilometersToMiles(10)
        if ([Math]::Abs($resultado - 6.21371) -lt 0.1) {
            Write-Host "  ? PASS - 10km = ${resultado}mi" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Esperado: 6.21371, Obtenido: $resultado" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    Write-Host ""
    Write-Host "=" * 50 -ForegroundColor White
    Write-Host "RESUMEN" -ForegroundColor White
    Write-Host "=" * 50 -ForegroundColor White
    Write-Host ""
    
    $total = $exitosos + $errores
    $porcentaje = if ($total -gt 0) { [Math]::Round(($exitosos / $total) * 100, 2) } else { 0 }
    
    Write-Host "URL: $serviceUrl" -ForegroundColor Cyan
    Write-Host "Total: $total pruebas" -ForegroundColor Cyan
    Write-Host "Exitosas: $exitosos" -ForegroundColor Green
    Write-Host "Fallidas: $errores" -ForegroundColor Red
    Write-Host "Éxito: $porcentaje%" -ForegroundColor $(if ($porcentaje -eq 100) {"Green"} else {"Yellow"})
    Write-Host ""
    
    if ($errores -eq 0) {
        Write-Host "?? ¡PERFECTO! Todos los métodos funcionan correctamente" -ForegroundColor Green
    } else {
        Write-Host "? Algunas pruebas fallaron" -ForegroundColor Yellow
    }
    
} catch {
    Write-Host ""
    Write-Host "? ERROR: No se pudo conectar al servicio" -ForegroundColor Red
    Write-Host "Detalles: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "SOLUCIÓN:" -ForegroundColor Yellow
    Write-Host "1. Verifica que el servicio esté ejecutándose (F5 en Visual Studio)" -ForegroundColor White
    Write-Host "2. Ejecuta ProbarServicioRed.bat para verificar conectividad" -ForegroundColor White
    Write-Host "3. Si no funciona, ejecuta ConfigurarIISExpress.bat como administrador" -ForegroundColor White
}

Write-Host ""
Write-Host "Presiona cualquier tecla para salir..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
