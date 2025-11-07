# ?? SERVICIO WCF - CONFIGURACIÓN SOLO EN RED

## ? Configuración Aplicada

### Especificaciones del Servicio:
- **Puerto**: `63393`
- **IP**: `192.168.137.1` (SOLO RED - No localhost)
- **Protocolo**: HTTP
- **URL del Servicio**: `http://192.168.137.1:63393/Service.svc`
- **URL del WSDL**: `http://192.168.137.1:63393/Service.svc?wsdl`

?? **IMPORTANTE**: El servicio NO funcionará en `localhost`. Solo estará disponible en la IP `192.168.137.1`.

---

## ?? PASOS OBLIGATORIOS PARA CONFIGURAR

### **Paso 1: Configurar la IP 192.168.137.1 en tu Adaptador de Red**

Antes de ejecutar el servicio, DEBES configurar tu adaptador de red con la IP 192.168.137.1:

#### Opción A: Configuración Manual (Recomendado)

1. Abre **Panel de Control** ? **Redes e Internet** ? **Centro de redes y recursos compartidos**
2. Haz clic en **Cambiar configuración del adaptador**
3. Haz clic derecho en tu adaptador de red (Wi-Fi o Ethernet) ? **Propiedades**
4. Selecciona **Protocolo de Internet versión 4 (TCP/IPv4)** ? **Propiedades**
5. Selecciona **Usar la siguiente dirección IP**
6. Configura:
   - **Dirección IP**: `192.168.137.1`
   - **Máscara de subred**: `255.255.255.0`
   - **Puerta de enlace predeterminada**: (déjalo vacío o según tu red)
   - **Servidor DNS preferido**: `8.8.8.8` (opcional)
7. Haz clic en **Aceptar**

#### Opción B: Configuración vía PowerShell (Como Administrador)

```powershell
# Verificar nombre del adaptador
Get-NetAdapter | Select-Object Name, Status, InterfaceDescription

# Configurar la IP (reemplaza "Wi-Fi" con el nombre de tu adaptador)
New-NetIPAddress -InterfaceAlias "Wi-Fi" -IPAddress 192.168.137.1 -PrefixLength 24

# Verificar
Get-NetIPAddress -IPAddress 192.168.137.1
```

#### Verificar que la IP esté configurada:

```powershell
ipconfig
```

Deberías ver:
```
Adaptador de LAN inalámbrica Wi-Fi:
   Dirección IPv4. . . . . . . . . . . : 192.168.137.1
   Máscara de subred . . . . . . . . . : 255.255.255.0
```

---

### **Paso 2: Configurar Firewall y URLs del Sistema**

1. Haz clic derecho en **`ConfigurarServicio.bat`**
2. Selecciona **"Ejecutar como administrador"**
3. Espera a que termine la configuración

Este paso configura:
- ? Firewall de Windows (puerto 63393)
- ? Reserva de URL para 192.168.137.1:63393
- ? Verifica que la IP esté configurada

---

### **Paso 3: Ejecutar Visual Studio como Administrador**

1. Cierra Visual Studio si está abierto
2. Haz clic derecho en el ícono de Visual Studio
3. Selecciona **"Ejecutar como administrador"**
4. Abre el proyecto del servidor

---

### **Paso 4: Ejecutar el Servicio**

1. En Visual Studio, presiona **F5**
2. Espera a que IIS Express inicie el servicio
3. El navegador se abrirá automáticamente intentando acceder al servicio

---

### **Paso 5: Verificar Conectividad**

Ejecuta **`ProbarServicio.bat`** (no requiere admin)

Este script verifica:
- ? Puerto 63393 está en uso
- ? IP 192.168.137.1 está configurada y activa
- ? Servicio responde en http://192.168.137.1:63393/Service.svc
- ? WSDL está accesible en http://192.168.137.1:63393/Service.svc?wsdl

**Resultado esperado:**
```
Pruebas exitosas: 2 de 2
? PASS - http://192.168.137.1:63393/Service.svc
? PASS - http://192.168.137.1:63393/Service.svc?wsdl
```

---

### **Paso 6: Ejecutar Pruebas Funcionales**

Ejecuta **`PruebasFuncionales.bat`** (no requiere admin)

Este script prueba TODOS los métodos del servicio:

**Resultado esperado:**
```
Exitosas: 9
Fallidas: 0
Porcentaje de éxito: 100%
?? ¡EXCELENTE! Todas las pruebas pasaron correctamente.
```

---

## ?? VERIFICACIÓN MANUAL

### Opción 1: Navegador Web
Abre en tu navegador (desde cualquier computadora en la misma red):
```
http://192.168.137.1:63393/Service.svc?wsdl
```

Deberías ver el documento XML del WSDL.

### Opción 2: WCF Test Client
1. Abre WCF Test Client:
   ```
   C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\Common7\IDE\WcfTestClient.exe
   ```
2. File ? Add Service
3. Ingresa: `http://192.168.137.1:63393/Service.svc?wsdl`
4. Prueba cada método

### Opción 3: PowerShell
```powershell
$client = New-WebServiceProxy -Uri "http://192.168.137.1:63393/Service.svc?wsdl"
$client.CelsiusToFahrenheit(25)  # Retorna: 77
$client.KilogramsToPounds(10)    # Retorna: 22.0462
$client.MetersToFeet(100)        # Retorna: 328.084
```

---

## ?? ACCEDER DESDE OTRA COMPUTADORA

### Requisitos:
1. La computadora del servidor debe tener la IP 192.168.137.1
2. Ambas computadoras deben estar en la misma red (subnet 192.168.137.x)
3. El firewall del servidor debe permitir conexiones en el puerto 63393
4. El servicio debe estar ejecutándose

### Desde otra computadora:

1. **Verificar conectividad:**
   ```cmd
   ping 192.168.137.1
   ```

2. **Abrir navegador:**
   ```
   http://192.168.137.1:63393/Service.svc?wsdl
   ```

3. **Crear cliente WCF:**
   - Crear nuevo proyecto (Console, WinForms, etc.)
   - Agregar Referencia de Servicio
   - URL: `http://192.168.137.1:63393/Service.svc`
   - Usar el servicio:
     ```csharp
     var client = new ServiceReference1.ServiceClient();
     double fahrenheit = client.CelsiusToFahrenheit(25);
     Console.WriteLine($"25°C = {fahrenheit}°F"); // 25°C = 77°F
     ```

---

## ?? SOLUCIÓN DE PROBLEMAS

### ? Error: "IP 192.168.137.1 NO encontrada en el sistema"

**Solución:**
1. Configura manualmente la IP en tu adaptador de red (ver Paso 1)
2. Verifica con `ipconfig` que la IP esté asignada
3. Ejecuta `ProbarServicio.bat` para verificar

### ? Error: "No se puede conectar al servicio"

**Causas posibles:**
1. La IP 192.168.137.1 no está configurada
2. Visual Studio no está ejecutándose como administrador
3. El servicio no está corriendo (presiona F5)
4. El firewall bloqueó la conexión
5. No ejecutaste `ConfigurarServicio.bat` como administrador

**Solución:**
1. Verifica cada punto arriba
2. Ejecuta `ProbarServicio.bat` para diagnóstico automático

### ? Error: "Puerto 63393 no está en uso"

**Solución:**
1. El servicio no está ejecutándose
2. Presiona F5 en Visual Studio
3. Verifica que no haya errores de compilación

### ? Error: "HTTP Error 503. The service is unavailable"

**Solución:**
1. Reinicia Visual Studio (como administrador)
2. Ejecuta `ConfigurarServicio.bat` nuevamente
3. Verifica el archivo Web.config

### ? No puedo acceder desde otra computadora

**Solución:**
1. Verifica que ambas computadoras estén en la misma red
2. Haz ping desde la otra computadora: `ping 192.168.137.1`
3. Verifica el firewall de Windows:
   ```powershell
   netsh advfirewall firewall show rule name="WCF Service Port 63393"
   ```
4. Temporalmente desactiva el firewall para probar

---

## ?? MÉTODOS DISPONIBLES EN EL SERVICIO

### Conversiones de Temperatura
```csharp
double CelsiusToFahrenheit(double celsius)
double FahrenheitToCelsius(double fahrenheit)
double CelsiusToKelvin(double celsius)
```

**Ejemplos:**
- `CelsiusToFahrenheit(25)` ? `77`
- `FahrenheitToCelsius(77)` ? `25`
- `CelsiusToKelvin(0)` ? `273.15`

### Conversiones de Masa
```csharp
double KilogramsToPounds(double kilograms)
double PoundsToKilograms(double pounds)
double KilogramsToOunces(double kilograms)
```

**Ejemplos:**
- `KilogramsToPounds(10)` ? `22.0462`
- `PoundsToKilograms(22.0462)` ? `10`
- `KilogramsToOunces(1)` ? `35.274`

### Conversiones de Longitud
```csharp
double MetersToFeet(double meters)
double FeetToMeters(double feet)
double KilometersToMiles(double kilometers)
```

**Ejemplos:**
- `MetersToFeet(100)` ? `328.084`
- `FeetToMeters(328.084)` ? `100`
- `KilometersToMiles(10)` ? `6.21371`

---

## ? ORDEN DE EJECUCIÓN COMPLETO

1. ? **Configurar IP 192.168.137.1** en el adaptador de red (Paso 1)
2. ? **ConfigurarServicio.bat** (como admin) - Configurar firewall y URLs
3. ? **Ejecutar Visual Studio como administrador**
4. ? **F5** en Visual Studio para iniciar el servicio
5. ? **ProbarServicio.bat** - Verificar conectividad
6. ? **PruebasFuncionales.bat** - Verificar funcionalidad
7. ? **Crear clientes** en otras computadoras si es necesario

---

## ?? ARCHIVOS DISPONIBLES

| Archivo | Descripción |
|---------|-------------|
| `ConfigurarServicio.bat` | Configura firewall y URLs (ejecutar como admin) |
| `ProbarServicio.bat` | Verifica conectividad del servicio |
| `PruebasFuncionales.bat` | Prueba todos los métodos del servicio |
| `TestService.html` | Página web de prueba visual |
| `INSTRUCCIONES_RED.md` | Este archivo |

---

## ?? NOTAS IMPORTANTES

1. **El servicio NO funcionará en localhost** - Solo en 192.168.137.1
2. **Debes configurar la IP manualmente** antes de iniciar el servicio
3. **Visual Studio DEBE ejecutarse como administrador**
4. **El firewall debe estar configurado** (ejecuta ConfigurarServicio.bat)
5. **Otras computadoras pueden acceder** si están en la misma red

---

**¡El servicio WCF está listo para funcionar en red con la IP 192.168.137.1!** ??
