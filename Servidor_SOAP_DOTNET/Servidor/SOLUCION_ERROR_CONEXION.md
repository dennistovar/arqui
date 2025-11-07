# ?? SOLUCIÓN AL ERROR "ECONNREFUSED 192.168.137.1:63393"

## ? Problema

Estás viendo el error:
```
Error: connect ECONNREFUSED 192.168.137.1:63393
```

Este error significa que **el servicio no puede enlazarse a la IP específica 192.168.137.1** porque:
1. La IP no existe en tu adaptador de red, o
2. IIS Express no tiene permisos para usar esa IP, o
3. Las URLs no están reservadas correctamente

---

## ? SOLUCIÓN RÁPIDA (Recomendada)

### Paso 1: Configurar IIS Express

1. **Cierra Visual Studio completamente**

2. **Ejecuta como Administrador:**
   ```
   ConfigurarIISExpress.bat
   ```
   
   Esto configurará:
   - ? Firewall
   - ? Reservas de URL para todas las IPs
   - ? Detectará automáticamente tu IP de red

3. **Abre Visual Studio como Administrador**
   - Haz clic derecho en Visual Studio
   - Selecciona "Ejecutar como administrador"

4. **Ejecuta el servicio (F5)**

5. **Verifica con:**
   ```
   ProbarServicioRed.bat
   ```

---

## ?? ¿Por Qué Ocurre el Error?

### Causa 1: IP No Configurada

Tu computadora NO tiene la IP 192.168.137.1 asignada a ningún adaptador de red.

**Verificar:**
```powershell
ipconfig
```

Busca si algún adaptador tiene la IP `192.168.137.1`.

**Solución Opción A - Detectar IP Automáticamente:**
Los nuevos scripts (`ConfigurarIISExpress.bat` y `ProbarServicioRed.bat`) detectan automáticamente tu IP real.

**Solución Opción B - Asignar la IP Manualmente:**
1. Panel de Control ? Redes ? Cambiar configuración del adaptador
2. Clic derecho en tu adaptador ? Propiedades
3. IPv4 ? Propiedades ? Usar la siguiente IP:
   - IP: `192.168.137.1`
   - Máscara: `255.255.255.0`

---

### Causa 2: Visual Studio No Ejecutándose Como Administrador

IIS Express necesita permisos de administrador para enlazarse a IPs específicas.

**Solución:**
1. Cierra Visual Studio
2. Haz clic derecho en Visual Studio
3. "Ejecutar como administrador"
4. Abre el proyecto
5. Presiona F5

---

### Causa 3: URLs No Reservadas

Windows requiere que las URLs estén reservadas para permitir que IIS Express las use.

**Verificar:**
```powershell
netsh http show urlacl
```

Busca entradas con el puerto `63393`.

**Solución:**
Ejecuta `ConfigurarIISExpress.bat` como administrador.

---

### Causa 4: Firewall Bloqueando

El firewall de Windows puede estar bloqueando el puerto.

**Verificar:**
```powershell
netsh advfirewall firewall show rule name=all | Select-String "63393"
```

**Solución:**
El script `ConfigurarIISExpress.bat` configura el firewall automáticamente.

---

## ?? PROCESO COMPLETO PASO A PASO

### 1?? Preparación

```cmd
# En el directorio del proyecto
cd Servidor
```

### 2?? Configurar el Sistema

**Ejecuta como Administrador:**
```cmd
ConfigurarIISExpress.bat
```

**Salida esperada:**
```
? Regla de firewall creada
? IP detectada: [TU_IP_REAL]
? URL reservada: http://localhost:63393/
? URL reservada: http://*:63393/
? URL reservada: http://+:63393/
? URL reservada: http://[TU_IP]:63393/
```

### 3?? Ejecutar Visual Studio

1. **Cierra Visual Studio si está abierto**

2. **Abre Visual Studio como Administrador:**
   - Clic derecho en el ícono de Visual Studio
   - "Ejecutar como administrador"

3. **Abre el proyecto del servidor**

4. **Presiona F5**

### 4?? Verificar Conectividad

**Ejecuta (NO requiere admin):**
```cmd
ProbarServicioRed.bat
```

**Salida esperada:**
```
? IP encontrada: [TU_IP]
? Puerto 63393 está en uso
? http://localhost:63393/Service.svc
? http://[TU_IP]:63393/Service.svc
? http://localhost:63393/Service.svc?wsdl
? http://[TU_IP]:63393/Service.svc?wsdl

Pruebas exitosas: 4 de 4
?? ¡PERFECTO! El servicio funciona correctamente
```

### 5?? Probar Funcionalidad

**Ejecuta:**
```cmd
PruebasFuncionalesRed.bat
```

**Salida esperada:**
```
? PASS - 25°C = 77°F
? PASS - 77°F = 25°C
? PASS - 0°C = 273.15K
... (9 pruebas)

Exitosas: 9
Fallidas: 0
?? ¡PERFECTO! Todos los métodos funcionan correctamente
```

---

## ?? Acceso Desde Otras Computadoras

Una vez configurado, otras computadoras pueden acceder usando tu IP real:

**Desde otra computadora:**
```
http://[TU_IP]:63393/Service.svc?wsdl
```

**Ejemplo:**
Si tu IP es `192.168.1.100`:
```
http://192.168.1.100:63393/Service.svc?wsdl
```

---

## ?? Si Aún No Funciona

### Opción 1: Verificar Proceso

```powershell
Get-NetTCPConnection -LocalPort 63393 | Format-Table -AutoSize
```

**Debe mostrar:**
- `State: Listen`
- `LocalAddress`: Debe incluir `0.0.0.0` o tu IP específica

### Opción 2: Verificar Reservas de URL

```powershell
netsh http show urlacl | Select-String "63393" -Context 2
```

**Debe mostrar al menos:**
```
URL reservada: http://localhost:63393/
URL reservada: http://+:63393/
```

### Opción 3: Ver Logs de IIS Express

1. Ve a Visual Studio
2. View ? Output (Ctrl+Alt+O)
3. Selecciona "Show output from: Debug"
4. Busca errores relacionados con el binding

### Opción 4: Reiniciar Todo

```cmd
# 1. Cerrar Visual Studio
# 2. Matar procesos de IIS Express
taskkill /F /IM iisexpress.exe

# 3. Ejecutar configuración
ConfigurarIISExpress.bat (como admin)

# 4. Abrir Visual Studio como admin
# 5. F5
```

---

## ?? Comparación de Configuraciones

| Configuración | Antes | Ahora |
|---------------|-------|-------|
| **IP Específica** | 192.168.137.1 (fija) | Detección automática |
| **Binding** | Solo una IP | Todas las IPs (*, +) |
| **Flexibilidad** | Baja | Alta |
| **Requiere Config** | Sí (manual) | Sí (automática) |
| **Funciona en Red** | Solo con esa IP | Con cualquier IP |

---

## ?? Resumen de Archivos Nuevos

| Archivo | Descripción | Requiere Admin |
|---------|-------------|----------------|
| `ConfigurarIISExpress.bat` | Configura IIS Express para red | ? Sí |
| `ConfigurarIISExpress.ps1` | Script de configuración | ? Sí |
| `ProbarServicioRed.bat` | Prueba conectividad (auto-detect IP) | ? No |
| `ProbarServicioRed.ps1` | Script de pruebas de conectividad | ? No |
| `PruebasFuncionalesRed.bat` | Prueba todos los métodos | ? No |
| `PruebasFuncionalesRed.ps1` | Script de pruebas funcionales | ? No |
| `SOLUCION_ERROR_CONEXION.md` | Este archivo | ? No |

---

## ? Checklist Final

Antes de reportar un problema, verifica:

- [ ] Ejecutaste `ConfigurarIISExpress.bat` como administrador
- [ ] Visual Studio está ejecutándose como administrador
- [ ] El servicio está corriendo (F5 en Visual Studio)
- [ ] El firewall permite el puerto 63393
- [ ] `ProbarServicioRed.bat` muestra "? Puerto 63393 está en uso"
- [ ] Puedes acceder a `http://localhost:63393/Service.svc?wsdl` en un navegador
- [ ] No hay otros procesos usando el puerto 63393

---

## ?? URLs de Prueba

Una vez configurado correctamente, estas URLs deben funcionar:

**Localmente:**
```
http://localhost:63393/Service.svc
http://localhost:63393/Service.svc?wsdl
```

**En Red (reemplaza [TU_IP] con tu IP real):**
```
http://[TU_IP]:63393/Service.svc
http://[TU_IP]:63393/Service.svc?wsdl
```

**Para Postman:**
```
POST http://localhost:63393/Service.svc
Headers:
  Content-Type: text/xml; charset=utf-8
  SOAPAction: "http://tempuri.org/IService/CelsiusToFahrenheit"
```

---

¡Con estos pasos, tu servicio debería funcionar perfectamente tanto localmente como en la red! ??
