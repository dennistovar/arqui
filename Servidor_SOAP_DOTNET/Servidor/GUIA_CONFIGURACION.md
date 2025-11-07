# Guía de Configuración y Pruebas del Servicio WCF

## ?? Configuración Realizada

### Puertos y URLs Configuradas:
- **Puerto**: 8080
- **URL Local**: http://localhost:8080/Service.svc
- **URL Red**: http://192.168.137.1:8080/Service.svc
- **WSDL Local**: http://localhost:8080/Service.svc?wsdl
- **WSDL Red**: http://192.168.137.1:8080/Service.svc?wsdl

## ?? Pasos para Configurar IIS Express

### 1. Configurar el archivo applicationhost.config

Ubicación del archivo:
```
.vs\Servidor\config\applicationhost.config
```

Busca la sección `<sites>` y modifica el binding del sitio para incluir:

```xml
<site name="Servidor" id="1">
  <application path="/" applicationPool="Clr4IntegratedAppPool">
    <virtualDirectory path="/" physicalPath="C:\ARQUITECTURA\TI1.2 SOAP_DOTNET_SINBDD_GRO#5\01.SERVIDOR\Servidor" />
  </application>
  <bindings>
    <binding protocol="http" bindingInformation="*:8080:localhost" />
    <binding protocol="http" bindingInformation="*:8080:192.168.137.1" />
  </bindings>
</site>
```

### 2. Ejecutar Visual Studio como Administrador

Para que IIS Express pueda enlazarse a una IP específica, necesitas ejecutar Visual Studio como administrador.

### 3. Configurar el Firewall de Windows

Abre PowerShell como administrador y ejecuta:

```powershell
# Permitir el puerto 8080 en el firewall
netsh advfirewall firewall add rule name="WCF Service Port 8080" dir=in action=allow protocol=TCP localport=8080

# Verificar que la regla se creó
netsh advfirewall firewall show rule name="WCF Service Port 8080"
```

### 4. Reservar la URL para la IP de red

Ejecuta en PowerShell como administrador:

```powershell
# Reservar la URL para todos los usuarios
netsh http add urlacl url=http://192.168.137.1:8080/ user=Everyone

# Verificar las reservas
netsh http show urlacl
```

## ?? Pruebas del Servicio

### Prueba 1: Verificar que el servicio está ejecutándose

1. Ejecuta el proyecto en Visual Studio (F5)
2. Abre un navegador y accede a:
   - http://localhost:8080/Service.svc
   - http://192.168.137.1:8080/Service.svc

Deberías ver la página de información del servicio WCF.

### Prueba 2: Verificar el WSDL

Accede a:
- http://localhost:8080/Service.svc?wsdl
- http://192.168.137.1:8080/Service.svc?wsdl

Deberías ver el documento XML del WSDL con todas las operaciones del servicio.

### Prueba 3: Probar desde otra máquina en la red

Desde otra computadora en la misma red:
1. Abre un navegador
2. Accede a: http://192.168.137.1:8080/Service.svc?wsdl
3. Si funciona, puedes crear un cliente WCF en esa máquina

## ?? Verificación con WCF Test Client

Visual Studio incluye una herramienta de prueba:

1. Ubica la herramienta en:
   ```
   C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\Common7\IDE\WcfTestClient.exe
   ```

2. Ejecuta WcfTestClient.exe

3. Agrega el servicio:
   - File ? Add Service
   - Ingresa: http://localhost:8080/Service.svc?wsdl
   - O: http://192.168.137.1:8080/Service.svc?wsdl

4. Prueba cada método:
   - CelsiusToFahrenheit(25) ? debería retornar 77
   - KilogramsToPounds(10) ? debería retornar 22.0462
   - MetersToFeet(100) ? debería retornar 328.084

## ?? Crear un Cliente de Consola para Pruebas

Crea un nuevo proyecto de consola y agrega la referencia al servicio:

```csharp
using System;

class Program
{
    static void Main()
    {
        // Cambia "ServiceReference1" por el nombre que le diste a la referencia
        var client = new ServiceReference1.ServiceClient();
        
        Console.WriteLine("=== PRUEBAS DE CONVERSIONES ===\n");
        
        // Temperatura
        Console.WriteLine("TEMPERATURA:");
        double celsius = 25;
        double fahrenheit = client.CelsiusToFahrenheit(celsius);
        Console.WriteLine($"{celsius}°C = {fahrenheit}°F");
        
        double kelvin = client.CelsiusToKelvin(celsius);
        Console.WriteLine($"{celsius}°C = {kelvin}K\n");
        
        // Masa
        Console.WriteLine("MASA:");
        double kg = 10;
        double pounds = client.KilogramsToPounds(kg);
        Console.WriteLine($"{kg} kg = {pounds:F2} lb");
        
        double ounces = client.KilogramsToOunces(kg);
        Console.WriteLine($"{kg} kg = {ounces:F2} oz\n");
        
        // Longitud
        Console.WriteLine("LONGITUD:");
        double meters = 100;
        double feet = client.MetersToFeet(meters);
        Console.WriteLine($"{meters} m = {feet:F2} ft");
        
        double km = 10;
        double miles = client.KilometersToMiles(km);
        Console.WriteLine($"{km} km = {miles:F2} mi");
        
        client.Close();
        
        Console.WriteLine("\nPresiona cualquier tecla para salir...");
        Console.ReadKey();
    }
}
```

## ?? Solución de Problemas

### El servicio no se conecta desde la red:

1. Verifica que el firewall esté configurado correctamente
2. Verifica que la IP 192.168.137.1 esté activa en tu adaptador de red:
   ```powershell
   ipconfig
   ```
3. Prueba hacer ping desde otra máquina:
   ```
   ping 192.168.137.1
   ```

### Error "HTTP Error 503. The service is unavailable":

1. Reinicia IIS Express
2. Verifica que el Application Pool esté corriendo
3. Revisa el archivo Web.config

### No se puede acceder al WSDL:

1. Verifica que `httpGetEnabled="true"` esté en el Web.config
2. Asegúrate de que el servicio esté ejecutándose
3. Verifica que no haya errores de compilación

## ?? Resultados Esperados de las Pruebas

| Conversión | Entrada | Salida Esperada |
|------------|---------|-----------------|
| CelsiusToFahrenheit | 25 | 77 |
| FahrenheitToCelsius | 77 | 25 |
| CelsiusToKelvin | 25 | 298.15 |
| KilogramsToPounds | 10 | 22.0462 |
| PoundsToKilograms | 22 | 9.979 |
| KilogramsToOunces | 10 | 352.74 |
| MetersToFeet | 100 | 328.084 |
| FeetToMeters | 328 | 99.97 |
| KilometersToMiles | 10 | 6.21371 |

## ? Checklist de Verificación

- [ ] El servicio se ejecuta en http://localhost:8080/Service.svc
- [ ] El WSDL es accesible en http://localhost:8080/Service.svc?wsdl
- [ ] El servicio responde desde http://192.168.137.1:8080/Service.svc
- [ ] El WSDL es accesible desde http://192.168.137.1:8080/Service.svc?wsdl
- [ ] El firewall permite conexiones en el puerto 8080
- [ ] Las conversiones de temperatura funcionan correctamente
- [ ] Las conversiones de masa funcionan correctamente
- [ ] Las conversiones de longitud funcionan correctamente
- [ ] Otras computadoras en la red pueden acceder al servicio
