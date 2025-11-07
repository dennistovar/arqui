# ?? CONFIGURACIÓN COMPLETADA - SERVICIO WCF

## ? Configuración Actualizada

### Puerto y Red Configurados:
- **Puerto**: `63393`
- **IP de Red**: `192.168.137.1`
- **Protocolo**: HTTP

### URLs del Servicio:
```
Local:  http://localhost:63393/Service.svc
Red:    http://192.168.137.1:63393/Service.svc
```

### URLs del WSDL:
```
Local:  http://localhost:63393/Service.svc?wsdl
Red:    http://192.168.137.1:63393/Service.svc?wsdl
```

---

## ?? PASOS PARA PONER EN FUNCIONAMIENTO

### **Paso 1: Configurar el Sistema (OBLIGATORIO - Solo una vez)**

1. Haz clic derecho en **`ConfigurarServicio.bat`**
2. Selecciona **"Ejecutar como administrador"**
3. Espera a que termine la configuración

Este paso configura:
- ? Firewall de Windows (puerto 63393)
- ? Reservas de URL para localhost
- ? Reservas de URL para 192.168.137.1
- ? Verifica la IP del adaptador de red

---

### **Paso 2: Ejecutar Visual Studio como Administrador**

**¡MUY IMPORTANTE!** Para que el servicio pueda enlazarse a la IP 192.168.137.1:

1. Cierra Visual Studio si está abierto
2. Haz clic derecho en Visual Studio
3. Selecciona **"Ejecutar como administrador"**
4. Abre el proyecto del servidor

---

### **Paso 3: Ejecutar el Servicio**

1. En Visual Studio, presiona **F5** para ejecutar el proyecto
2. Espera a que IIS Express inicie el servicio
3. Deberías ver que el navegador se abre automáticamente

---

### **Paso 4: Verificar Conectividad**

Ejecuta **`ProbarServicio.bat`** (no requiere admin)

Este script verifica:
- ? Puerto 63393 está en uso
- ? IP 192.168.137.1 está disponible
- ? Servicio responde en localhost
- ? Servicio responde en la red
- ? WSDL está accesible

---

### **Paso 5: Ejecutar Pruebas Funcionales**

Ejecuta **`PruebasFuncionales.bat`** (no requiere admin)

Este script prueba TODOS los métodos del servicio:

**Conversiones de Temperatura:**
- ? CelsiusToFahrenheit(25) ? 77°F
- ? FahrenheitToCelsius(77) ? 25°C
- ? CelsiusToKelvin(0) ? 273.15K

**Conversiones de Masa:**
- ? KilogramsToPounds(10) ? 22.0462 lb
- ? PoundsToKilograms(22.0462) ? 10 kg
- ? KilogramsToOunces(1) ? 35.274 oz

**Conversiones de Longitud:**
- ? MetersToFeet(100) ? 328.084 ft
- ? FeetToMeters(328.084) ? 100 m
- ? KilometersToMiles(10) ? 6.21371 mi

---

## ?? VERIFICACIÓN MANUAL

### Opción 1: Navegador Web
Abre en tu navegador:
```
http://192.168.137.1:63393/Service.svc?wsdl
```

Deberías ver el documento XML del WSDL con todas las operaciones.

### Opción 2: WCF Test Client
1. Abre WCF Test Client (incluido en Visual Studio):
   ```
   C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\Common7\IDE\WcfTestClient.exe
   ```
2. File ? Add Service
3. Ingresa la URL:
   ```
   http://192.168.137.1:63393/Service.svc?wsdl
   ```
4. Prueba cada método con diferentes valores

### Opción 3: PowerShell
```powershell
$client = New-WebServiceProxy -Uri "http://192.168.137.1:63393/Service.svc?wsdl"
$client.CelsiusToFahrenheit(25)  # Retorna: 77
$client.KilogramsToPounds(10)    # Retorna: 22.0462
$client.MetersToFeet(100)        # Retorna: 328.084
```

---

## ?? PRUEBAS DESDE OTRA COMPUTADORA EN LA RED

### Requisitos:
1. Ambas computadoras deben estar en la misma red
2. La computadora del servidor debe tener la IP 192.168.137.1
3. El firewall debe estar configurado (Paso 1)
4. El servicio debe estar ejecutándose (Paso 3)

### Desde la otra computadora:
1. Abre un navegador web
2. Accede a:
   ```
   http://192.168.137.1:63393/Service.svc?wsdl
   ```
3. Si funciona, puedes crear un cliente WCF en esa computadora

### Crear Cliente en otra computadora:
1. Crea un nuevo proyecto (Console, WinForms, WPF, etc.)
2. Clic derecho en el proyecto ? Agregar ? Referencia de Servicio
3. URL del servicio:
   ```
   http://192.168.137.1:63393/Service.svc
   ```
4. Dale un nombre (ej: "ServiceReference1")
5. Usa el servicio:
   ```csharp
   var client = new ServiceReference1.ServiceClient();
   double resultado = client.CelsiusToFahrenheit(25);
   Console.WriteLine($"25°C = {resultado}°F");
   ```

---

## ?? SOLUCIÓN DE PROBLEMAS

### ? "No se puede conectar al servicio"
**Solución:**
1. Verifica que Visual Studio esté ejecutándose como administrador
2. Verifica que el servicio esté corriendo (F5)
3. Ejecuta `ProbarServicio.bat` para diagnóstico

### ? "Puerto 63393 no está en uso"
**Solución:**
1. El servicio no está ejecutándose
2. Presiona F5 en Visual Studio
3. Verifica que no haya errores de compilación

### ? "IP 192.168.137.1 no encontrada"
**Solución:**
1. Verifica tu configuración de red con `ipconfig`
2. Asegúrate de que el adaptador de red tenga esa IP
3. Puedes cambiar la IP en Web.config si es necesaria otra

### ? "HTTP Error 503. The service is unavailable"
**Solución:**
1. Reinicia Visual Studio (como administrador)
2. Ejecuta `ConfigurarServicio.bat` nuevamente
3. Verifica que el Web.config esté correcto

### ? "Access is denied" al reservar URLs
**Solución:**
1. Asegúrate de ejecutar `ConfigurarServicio.bat` como administrador
2. Si persiste, ejecuta manualmente en PowerShell (como admin):
   ```powershell
   netsh http add urlacl url=http://192.168.137.1:63393/ user=Everyone
   ```

---

## ?? RESULTADOS ESPERADOS

Si todo está configurado correctamente, deberías ver:

? **ProbarServicio.bat:**
```
Pruebas exitosas: 4 de 4
? PASS - http://localhost:63393/Service.svc
? PASS - http://192.168.137.1:63393/Service.svc
? PASS - http://localhost:63393/Service.svc?wsdl
? PASS - http://192.168.137.1:63393/Service.svc?wsdl
```

? **PruebasFuncionales.bat:**
```
Exitosas: 9
Fallidas: 0
Porcentaje de éxito: 100%
?? ¡EXCELENTE! Todas las pruebas pasaron correctamente.
```

---

## ?? ARCHIVOS CREADOS

| Archivo | Descripción |
|---------|-------------|
| `ConfigurarServicio.bat` | Configura firewall y URLs (ejecutar como admin) |
| `ConfigurarServicio.ps1` | Script PowerShell de configuración |
| `ProbarServicio.bat` | Prueba la conectividad del servicio |
| `ProbarServicio.ps1` | Script PowerShell de pruebas de conectividad |
| `PruebasFuncionales.bat` | Prueba todos los métodos del servicio |
| `PruebasFuncionales.ps1` | Script PowerShell de pruebas funcionales |
| `TestService.html` | Página web de prueba visual |
| `GUIA_CONFIGURACION.md` | Documentación detallada |
| `RESUMEN_PRUEBAS.md` | Este archivo |

---

## ? ORDEN DE EJECUCIÓN RECOMENDADO

1. ? **ConfigurarServicio.bat** (como admin) - Solo una vez
2. ? **Ejecutar Visual Studio como administrador**
3. ? **F5** en Visual Studio para iniciar el servicio
4. ? **ProbarServicio.bat** - Verificar conectividad
5. ? **PruebasFuncionales.bat** - Verificar funcionalidad
6. ? **Crear clientes** en otras computadoras si es necesario

---

## ?? PRÓXIMOS PASOS

Una vez que el servicio esté funcionando:

1. **Crear Cliente Windows Forms** para usar las conversiones
2. **Crear Cliente Console App** para pruebas rápidas
3. **Documentar las APIs** para otros desarrolladores
4. **Considerar HTTPS** para mayor seguridad (puerto 443 o 44393)
5. **Implementar logging** para monitorear el uso del servicio

---

## ?? CONTACTO Y SOPORTE

Si tienes problemas:
1. Revisa la sección "Solución de Problemas" arriba
2. Ejecuta `ProbarServicio.bat` para diagnóstico automático
3. Verifica los logs en la ventana Output de Visual Studio
4. Revisa el Event Viewer de Windows para errores de IIS Express

---

**¡El servicio WCF está listo para funcionar en red!** ??
