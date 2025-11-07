# Script de Pruebas Funcionales del Servicio WCF
# Prueba todos los métodos de conversión

Write-Host "=== PRUEBAS FUNCIONALES DEL SERVICIO WCF ===" -ForegroundColor Green
Write-Host "Puerto: 63393 | IP: 192.168.137.1 (SOLO RED)" -ForegroundColor Cyan
Write-Host ""

$serviceUrl = "http://192.168.137.1:63393/Service.svc?wsdl"

Write-Host "Conectando al servicio en: $serviceUrl" -ForegroundColor Cyan
Write-Host ""

try {
    # Intentar crear el proxy del servicio
    Write-Host "Creando proxy del servicio..." -ForegroundColor Yellow
    $proxy = New-WebServiceProxy -Uri $serviceUrl -ErrorAction Stop
    Write-Host "? Proxy creado exitosamente" -ForegroundColor Green
    Write-Host ""
    
    $errores = 0
    $exitosos = 0
    
    # ==================================================
    # PRUEBAS DE TEMPERATURA
    # ==================================================
    Write-Host "=== CONVERSIONES DE TEMPERATURA ===" -ForegroundColor Magenta
    Write-Host ""
    
    # Prueba 1: Celsius a Fahrenheit
    try {
        Write-Host "Prueba 1: CelsiusToFahrenheit(25)" -ForegroundColor Cyan
        $resultado = $proxy.CelsiusToFahrenheit(25)
        $esperado = 77
        if ([Math]::Abs($resultado - $esperado) -lt 0.1) {
            Write-Host "  ? PASS - Resultado: $resultado °F (Esperado: $esperado °F)" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Resultado: $resultado °F (Esperado: $esperado °F)" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    # Prueba 2: Fahrenheit a Celsius
    try {
        Write-Host "Prueba 2: FahrenheitToCelsius(77)" -ForegroundColor Cyan
        $resultado = $proxy.FahrenheitToCelsius(77)
        $esperado = 25
        if ([Math]::Abs($resultado - $esperado) -lt 0.1) {
            Write-Host "  ? PASS - Resultado: $resultado °C (Esperado: $esperado °C)" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Resultado: $resultado °C (Esperado: $esperado °C)" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    # Prueba 3: Celsius a Kelvin
    try {
        Write-Host "Prueba 3: CelsiusToKelvin(0)" -ForegroundColor Cyan
        $resultado = $proxy.CelsiusToKelvin(0)
        $esperado = 273.15
        if ([Math]::Abs($resultado - $esperado) -lt 0.1) {
            Write-Host "  ? PASS - Resultado: $resultado K (Esperado: $esperado K)" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Resultado: $resultado K (Esperado: $esperado K)" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    Write-Host ""
    
    # ==================================================
    # PRUEBAS DE MASA
    # ==================================================
    Write-Host "=== CONVERSIONES DE MASA ===" -ForegroundColor Magenta
    Write-Host ""
    
    # Prueba 4: Kilogramos a Libras
    try {
        Write-Host "Prueba 4: KilogramsToPounds(10)" -ForegroundColor Cyan
        $resultado = $proxy.KilogramsToPounds(10)
        $esperado = 22.0462
        if ([Math]::Abs($resultado - $esperado) -lt 0.1) {
            Write-Host "  ? PASS - Resultado: $resultado lb (Esperado: ~$esperado lb)" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Resultado: $resultado lb (Esperado: ~$esperado lb)" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    # Prueba 5: Libras a Kilogramos
    try {
        Write-Host "Prueba 5: PoundsToKilograms(22.0462)" -ForegroundColor Cyan
        $resultado = $proxy.PoundsToKilograms(22.0462)
        $esperado = 10
        if ([Math]::Abs($resultado - $esperado) -lt 0.1) {
            Write-Host "  ? PASS - Resultado: $resultado kg (Esperado: $esperado kg)" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Resultado: $resultado kg (Esperado: $esperado kg)" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    # Prueba 6: Kilogramos a Onzas
    try {
        Write-Host "Prueba 6: KilogramsToOunces(1)" -ForegroundColor Cyan
        $resultado = $proxy.KilogramsToOunces(1)
        $esperado = 35.274
        if ([Math]::Abs($resultado - $esperado) -lt 0.1) {
            Write-Host "  ? PASS - Resultado: $resultado oz (Esperado: ~$esperado oz)" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Resultado: $resultado oz (Esperado: ~$esperado oz)" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    Write-Host ""
    
    # ==================================================
    # PRUEBAS DE LONGITUD
    # ==================================================
    Write-Host "=== CONVERSIONES DE LONGITUD ===" -ForegroundColor Magenta
    Write-Host ""
    
    # Prueba 7: Metros a Pies
    try {
        Write-Host "Prueba 7: MetersToFeet(100)" -ForegroundColor Cyan
        $resultado = $proxy.MetersToFeet(100)
        $esperado = 328.084
        if ([Math]::Abs($resultado - $esperado) -lt 0.1) {
            Write-Host "  ? PASS - Resultado: $resultado ft (Esperado: ~$esperado ft)" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Resultado: $resultado ft (Esperado: ~$esperado ft)" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    # Prueba 8: Pies a Metros
    try {
        Write-Host "Prueba 8: FeetToMeters(328.084)" -ForegroundColor Cyan
        $resultado = $proxy.FeetToMeters(328.084)
        $esperado = 100
        if ([Math]::Abs($resultado - $esperado) -lt 0.1) {
            Write-Host "  ? PASS - Resultado: $resultado m (Esperado: $esperado m)" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Resultado: $resultado m (Esperado: $esperado m)" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    # Prueba 9: Kilómetros a Millas
    try {
        Write-Host "Prueba 9: KilometersToMiles(10)" -ForegroundColor Cyan
        $resultado = $proxy.KilometersToMiles(10)
        $esperado = 6.21371
        if ([Math]::Abs($resultado - $esperado) -lt 0.1) {
            Write-Host "  ? PASS - Resultado: $resultado mi (Esperado: ~$esperado mi)" -ForegroundColor Green
            $exitosos++
        } else {
            Write-Host "  ? FAIL - Resultado: $resultado mi (Esperado: ~$esperado mi)" -ForegroundColor Red
            $errores++
        }
    } catch {
        Write-Host "  ? ERROR: $_" -ForegroundColor Red
        $errores++
    }
    
    Write-Host ""
    Write-Host "================================================" -ForegroundColor White
    Write-Host "RESUMEN FINAL DE PRUEBAS" -ForegroundColor White
    Write-Host "================================================" -ForegroundColor White
    Write-Host ""
    
    $total = $exitosos + $errores
    $porcentaje = if ($total -gt 0) { [Math]::Round(($exitosos / $total) * 100, 2) } else { 0 }
    
    Write-Host "URL Probada: http://192.168.137.1:63393/Service.svc" -ForegroundColor Cyan
    Write-Host "Total de pruebas: $total" -ForegroundColor Cyan
    Write-Host "Exitosas: $exitosos" -ForegroundColor Green
    Write-Host "Fallidas: $errores" -ForegroundColor Red
    Write-Host "Porcentaje de éxito: $porcentaje%" -ForegroundColor $(if ($porcentaje -eq 100) {"Green"} elseif ($porcentaje -ge 70) {"Yellow"} else {"Red"})
    Write-Host ""
    
    if ($errores -eq 0) {
        Write-Host "?? ¡EXCELENTE! Todas las pruebas pasaron correctamente." -ForegroundColor Green
        Write-Host "El servicio WCF está funcionando perfectamente en http://192.168.137.1:63393" -ForegroundColor Green
    } elseif ($exitosos -gt $errores) {
        Write-Host "? La mayoría de las pruebas pasaron, pero hay algunos errores." -ForegroundColor Yellow
        Write-Host "Revisa las pruebas fallidas arriba." -ForegroundColor Yellow
    } else {
        Write-Host "? Muchas pruebas fallaron. Verifica la implementación del servicio." -ForegroundColor Red
    }
    
} catch {
    Write-Host ""
    Write-Host "? ERROR CRÍTICO: No se pudo conectar al servicio" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Verifica que:" -ForegroundColor Yellow
    Write-Host "  1. La IP 192.168.137.1 esté configurada en tu adaptador de red" -ForegroundColor White
    Write-Host "  2. El servicio esté ejecutándose (F5 en Visual Studio como administrador)" -ForegroundColor White
    Write-Host "  3. La URL sea correcta: $serviceUrl" -ForegroundColor White
    Write-Host "  4. El firewall permita conexiones al puerto 63393" -ForegroundColor White
    Write-Host "  5. Hayas ejecutado ConfigurarServicio.bat como administrador" -ForegroundColor White
    Write-Host ""
    Write-Host "Ejecuta ProbarServicio.bat primero para diagnóstico detallado." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Presiona cualquier tecla para salir..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
