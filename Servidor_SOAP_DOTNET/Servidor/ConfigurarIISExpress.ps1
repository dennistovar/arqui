# Script para Configurar IIS Express para Acceso en Red
# Ejecutar como Administrador

Write-Host "=== Configuración de IIS Express para Acceso en Red ===" -ForegroundColor Green
Write-Host ""

# Obtener el puerto actual del proyecto
$puerto = "63393"
Write-Host "Puerto detectado: $puerto" -ForegroundColor Cyan
Write-Host ""

# 1. Configurar Firewall
Write-Host "1. Configurando Firewall..." -ForegroundColor Yellow
try {
    netsh advfirewall firewall delete rule name="IIS Express - Puerto $puerto" 2>$null
    netsh advfirewall firewall add rule name="IIS Express - Puerto $puerto" dir=in action=allow protocol=TCP localport=$puerto
    Write-Host "   ? Regla de firewall creada" -ForegroundColor Green
} catch {
    Write-Host "   ? Error: $_" -ForegroundColor Red
}

Write-Host ""

# 2. Obtener la IP local (no localhost)
Write-Host "2. Detectando IP de red local..." -ForegroundColor Yellow
$localIP = Get-NetIPAddress -AddressFamily IPv4 | 
    Where-Object {$_.IPAddress -notlike "127.*" -and $_.IPAddress -notlike "169.254.*"} | 
    Select-Object -First 1 -ExpandProperty IPAddress

if ($localIP) {
    Write-Host "   ? IP detectada: $localIP" -ForegroundColor Green
} else {
    Write-Host "   ? No se detectó IP de red. Usando 0.0.0.0 (todas las interfaces)" -ForegroundColor Yellow
    $localIP = "0.0.0.0"
}

Write-Host ""

# 3. Reservar URLs
Write-Host "3. Reservando URLs..." -ForegroundColor Yellow

# Reservar para localhost
try {
    netsh http delete urlacl url=http://localhost:$puerto/ 2>$null
    netsh http add urlacl url=http://localhost:$puerto/ user=Everyone
    Write-Host "   ? URL reservada: http://localhost:$puerto/" -ForegroundColor Green
} catch {
    Write-Host "   ? Advertencia: $_" -ForegroundColor Yellow
}

# Reservar para todas las IPs (*)
try {
    netsh http delete urlacl url=http://*:$puerto/ 2>$null
    netsh http add urlacl url=http://*:$puerto/ user=Everyone
    Write-Host "   ? URL reservada: http://*:$puerto/ (todas las IPs)" -ForegroundColor Green
} catch {
    Write-Host "   ? Advertencia: $_" -ForegroundColor Yellow
}

# Reservar para +
try {
    netsh http delete urlacl url=http://+:$puerto/ 2>$null
    netsh http add urlacl url=http://+:$puerto/ user=Everyone
    Write-Host "   ? URL reservada: http://+:$puerto/" -ForegroundColor Green
} catch {
    Write-Host "   ? Advertencia: $_" -ForegroundColor Yellow
}

# Reservar para la IP específica si existe
if ($localIP -ne "0.0.0.0") {
    try {
        netsh http delete urlacl url=http://${localIP}:$puerto/ 2>$null
        netsh http add urlacl url=http://${localIP}:$puerto/ user=Everyone
        Write-Host "   ? URL reservada: http://${localIP}:$puerto/" -ForegroundColor Green
    } catch {
        Write-Host "   ? Advertencia: $_" -ForegroundColor Yellow
    }
}

# Reservar para 192.168.137.1
try {
    netsh http delete urlacl url=http://192.168.137.1:$puerto/ 2>$null
    netsh http add urlacl url=http://192.168.137.1:$puerto/ user=Everyone
    Write-Host "   ? URL reservada: http://192.168.137.1:$puerto/" -ForegroundColor Green
} catch {
    Write-Host "   ? Advertencia: $_" -ForegroundColor Yellow
}

Write-Host ""

# 4. Buscar y modificar applicationhost.config
Write-Host "4. Buscando archivo de configuración de IIS Express..." -ForegroundColor Yellow

$possiblePaths = @(
    ".\.vs\config\applicationhost.config",
    ".\.vs\Servidor\config\applicationhost.config",
    "$env:USERPROFILE\Documents\IISExpress\config\applicationhost.config",
    "$env:APPDATA\..\Local\Temp\iisexpress\config\applicationhost.config"
)

$configPath = $null
foreach ($path in $possiblePaths) {
    if (Test-Path $path) {
        $configPath = $path
        Write-Host "   ? Encontrado: $configPath" -ForegroundColor Green
        break
    }
}

if ($configPath) {
    Write-Host "   Modificando bindings..." -ForegroundColor Cyan
    Write-Host "   NOTA: Esto debe hacerse manualmente en algunos casos" -ForegroundColor Yellow
    Write-Host "   Ubicación: $configPath" -ForegroundColor White
} else {
    Write-Host "   ? No se encontró applicationhost.config" -ForegroundColor Yellow
    Write-Host "   Se creará automáticamente cuando ejecutes el proyecto" -ForegroundColor White
}

Write-Host ""

# 5. Verificar configuración actual
Write-Host "5. Verificando configuración..." -ForegroundColor Yellow
Write-Host ""
Write-Host "URLs Reservadas:" -ForegroundColor Cyan
netsh http show urlacl | Select-String -Pattern $puerto -Context 1,1

Write-Host ""
Write-Host "Reglas de Firewall:" -ForegroundColor Cyan
netsh advfirewall firewall show rule name="IIS Express - Puerto $puerto"

Write-Host ""
Write-Host "=== CONFIGURACIÓN COMPLETADA ===" -ForegroundColor Green
Write-Host ""
Write-Host "?? INSTRUCCIONES IMPORTANTES:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. CIERRA Visual Studio completamente" -ForegroundColor White
Write-Host ""
Write-Host "2. HAZ CLIC DERECHO en Visual Studio ? 'Ejecutar como Administrador'" -ForegroundColor White
Write-Host ""
Write-Host "3. Abre tu proyecto y PRESIONA F5" -ForegroundColor White
Write-Host ""
Write-Host "4. El servicio estará disponible en:" -ForegroundColor Cyan
Write-Host "   • http://localhost:$puerto/Service.svc" -ForegroundColor White
if ($localIP -ne "0.0.0.0") {
    Write-Host "   • http://${localIP}:$puerto/Service.svc" -ForegroundColor White
}
Write-Host "   • http://192.168.137.1:$puerto/Service.svc (si configuraste esta IP)" -ForegroundColor White
Write-Host ""
Write-Host "5. Prueba la conectividad ejecutando: ProbarServicioRed.bat" -ForegroundColor White
Write-Host ""

Write-Host "Presiona cualquier tecla para continuar..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
