# Script de Configuración del Servicio WCF
# Ejecutar como Administrador

Write-Host "=== Configuración del Servicio WCF SOLO en Red ===" -ForegroundColor Green
Write-Host "IP: 192.168.137.1 | Puerto: 63393" -ForegroundColor Cyan
Write-Host ""

# 1. Agregar regla de firewall
Write-Host "1. Configurando Firewall para puerto 63393..." -ForegroundColor Yellow
try {
    netsh advfirewall firewall delete rule name="WCF Service Port 63393" 2>$null
    netsh advfirewall firewall add rule name="WCF Service Port 63393" dir=in action=allow protocol=TCP localport=63393
    Write-Host "   ? Regla de firewall agregada correctamente" -ForegroundColor Green
} catch {
    Write-Host "   ? Error al configurar firewall: $_" -ForegroundColor Red
}

Write-Host ""

# 2. Reservar URL para la IP de red 192.168.137.1
Write-Host "2. Reservando URL para 192.168.137.1:63393..." -ForegroundColor Yellow
try {
    netsh http delete urlacl url=http://192.168.137.1:63393/ 2>$null
    netsh http add urlacl url=http://192.168.137.1:63393/ user=Everyone
    Write-Host "   ? URL reservada correctamente para 192.168.137.1" -ForegroundColor Green
} catch {
    Write-Host "   ? Error al reservar URL: $_" -ForegroundColor Red
}

Write-Host ""

# 3. Reservar URL con el símbolo + para todas las interfaces
Write-Host "3. Reservando URL para todas las interfaces (+:63393)..." -ForegroundColor Yellow
try {
    netsh http delete urlacl url=http://+:63393/ 2>$null
    netsh http add urlacl url=http://+:63393/ user=Everyone
    Write-Host "   ? URL reservada correctamente para todas las interfaces" -ForegroundColor Green
} catch {
    Write-Host "   ? Error al reservar URL: $_" -ForegroundColor Red
}

Write-Host ""

# 4. Mostrar configuración actual
Write-Host "4. Verificando configuración..." -ForegroundColor Yellow
Write-Host ""
Write-Host "Reglas de Firewall:" -ForegroundColor Cyan
netsh advfirewall firewall show rule name="WCF Service Port 63393"

Write-Host ""
Write-Host "URLs Reservadas:" -ForegroundColor Cyan
netsh http show urlacl | Select-String -Pattern "63393" -Context 2,2

Write-Host ""

# 5. Verificar que la IP 192.168.137.1 esté configurada
Write-Host "5. Verificando configuración de red..." -ForegroundColor Yellow
$ip = Get-NetIPAddress | Where-Object {$_.IPAddress -eq "192.168.137.1"}
if ($ip) {
    Write-Host "   ? IP 192.168.137.1 encontrada en el adaptador: $($ip.InterfaceAlias)" -ForegroundColor Green
} else {
    Write-Host "   ? ADVERTENCIA: IP 192.168.137.1 no encontrada en ningún adaptador" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "   Para configurar la IP 192.168.137.1 manualmente:" -ForegroundColor Cyan
    Write-Host "   1. Abre 'Panel de Control' -> 'Redes e Internet' -> 'Conexiones de red'" -ForegroundColor White
    Write-Host "   2. Haz clic derecho en tu adaptador de red -> Propiedades" -ForegroundColor White
    Write-Host "   3. Selecciona 'Protocolo de Internet versión 4 (TCP/IPv4)' -> Propiedades" -ForegroundColor White
    Write-Host "   4. Selecciona 'Usar la siguiente dirección IP'" -ForegroundColor White
    Write-Host "   5. Ingresa: IP: 192.168.137.1, Máscara: 255.255.255.0" -ForegroundColor White
    Write-Host ""
    Write-Host "   IPs disponibles actualmente:" -ForegroundColor Cyan
    Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.IPAddress -notlike "127.*"} | 
        Format-Table IPAddress, InterfaceAlias, PrefixOrigin -AutoSize
}

Write-Host ""
Write-Host "=== Configuración Completada ===" -ForegroundColor Green
Write-Host ""
Write-Host "URL del Servicio (SOLO RED):" -ForegroundColor Cyan
Write-Host "  http://192.168.137.1:63393/Service.svc" -ForegroundColor White
Write-Host ""
Write-Host "WSDL:" -ForegroundColor Cyan
Write-Host "  http://192.168.137.1:63393/Service.svc?wsdl" -ForegroundColor White
Write-Host ""
Write-Host "? IMPORTANTE: El servicio NO estará disponible en localhost" -ForegroundColor Yellow
Write-Host "  Solo será accesible desde la IP 192.168.137.1" -ForegroundColor Yellow
Write-Host ""
Write-Host "Presiona cualquier tecla para continuar..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
