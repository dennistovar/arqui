# ?? Guía Rápida de Postman - Paso a Paso

## ?? Importar la Colección

### Paso 1: Abre Postman
1. Inicia Postman en tu computadora
2. Si no lo tienes, descárgalo de: https://www.postman.com/downloads/

### Paso 2: Importar el archivo JSON
1. Haz clic en el botón **"Import"** (arriba a la izquierda)
2. Haz clic en **"Upload Files"**
3. Selecciona el archivo: `WCF_Conversiones_Postman_Collection.json`
4. Haz clic en **"Import"**

### Paso 3: Verificar la importación
En el panel izquierdo verás:
```
?? WCF Servicio de Conversiones
  ??? 0. Verificar WSDL
  ??? ?? Conversiones de Temperatura
  ?   ??? CelsiusToFahrenheit
  ?   ??? FahrenheitToCelsius
  ?   ??? CelsiusToKelvin
  ??? ?? Conversiones de Masa
  ?   ??? KilogramsToPounds
  ?   ??? PoundsToKilograms
  ?   ??? KilogramsToOunces
  ??? ?? Conversiones de Longitud
      ??? MetersToFeet
      ??? FeetToMeters
      ??? KilometersToMiles
```

---

## ? Prueba 1: Verificar WSDL

### Configuración:
- **Método:** GET
- **URL:** `http://192.168.137.1:63393/Service.svc?wsdl`

### Pasos:
1. Haz clic en **"0. Verificar WSDL"** en la colección
2. Haz clic en el botón **"Send"** (azul, arriba a la derecha)
3. Espera la respuesta

### Resultado Esperado:
```
Status: 200 OK
Body: XML con el documento WSDL completo
```

Si ves esto, ¡tu servicio está funcionando! ?

---

## ??? Prueba 2: CelsiusToFahrenheit

### Configuración:
- **Método:** POST
- **URL:** `http://192.168.137.1:63393/Service.svc`

### Headers:
```
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://tempuri.org/IService/CelsiusToFahrenheit"
```

### Body (XML):
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" 
               xmlns:tem="http://tempuri.org/">
  <soap:Body>
    <tem:CelsiusToFahrenheit>
      <tem:celsius>25</tem:celsius>
    </tem:CelsiusToFahrenheit>
  </soap:Body>
</soap:Envelope>
```

### Pasos:
1. Expande **"Conversiones de Temperatura"**
2. Haz clic en **"CelsiusToFahrenheit"**
3. Verifica que los Headers estén configurados (pestaña "Headers")
4. Verifica el Body XML (pestaña "Body")
5. Haz clic en **"Send"**

### Resultado Esperado:
```xml
<?xml version="1.0" encoding="utf-8"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
  <s:Body>
    <CelsiusToFahrenheitResponse xmlns="http://tempuri.org/">
      <CelsiusToFahrenheitResult>77</CelsiusToFahrenheitResult>
    </CelsiusToFahrenheitResponse>
  </s:Body>
</s:Envelope>
```

**El valor 77 indica que 25°C = 77°F** ?

---

## ?? Cómo Modificar los Valores

### Para probar con diferentes valores:

1. Haz clic en la pestaña **"Body"**
2. Busca la línea que contiene el valor:
   ```xml
   <tem:celsius>25</tem:celsius>
   ```
3. Cambia `25` por el valor que quieras probar, ejemplo:
   ```xml
   <tem:celsius>100</tem:celsius>
   ```
4. Haz clic en **"Send"**
5. El resultado debería ser `212` (100°C = 212°F)

---

## ?? Ejemplos de Pruebas Rápidas

### Temperatura:
```
25°C ? 77°F
0°C ? 32°F
100°C ? 212°F
-40°C ? -40°F (¡son iguales!)
```

### Masa:
```
1 kg ? 2.20462 lb
10 kg ? 22.0462 lb
50 kg ? 110.231 lb
```

### Longitud:
```
1 m ? 3.28084 ft
10 m ? 32.8084 ft
100 km ? 62.1371 mi
```

---

## ?? Entendiendo la Respuesta SOAP

### Estructura de la Respuesta:

```xml
<?xml version="1.0" encoding="utf-8"?>
<s:Envelope>                          ? Sobre SOAP
  <s:Body>                            ? Cuerpo del mensaje
    <CelsiusToFahrenheitResponse>     ? Nombre del método + Response
      <CelsiusToFahrenheitResult>     ? Nombre del método + Result
        77                            ? ¡EL RESULTADO ESTÁ AQUÍ!
      </CelsiusToFahrenheitResult>
    </CelsiusToFahrenheitResponse>
  </s:Body>
</s:Envelope>
```

**El valor numérico que buscas está dentro del elemento `[NombreMetodo]Result`**

---

## ?? Configuración Avanzada

### Crear un Environment (Opcional)

Esto te permite cambiar fácilmente entre diferentes servidores:

1. Haz clic en el ícono de ojo (???) arriba a la derecha
2. Haz clic en **"Add"** junto a "Environments"
3. Nombre: **"WCF Local"**
4. Agrega estas variables:

| Variable | Valor |
|----------|-------|
| baseUrl | http://192.168.137.1:63393/Service.svc |
| namespace | http://tempuri.org/ |

5. Guarda el environment
6. Selecciónalo en el dropdown (arriba a la derecha)

Ahora puedes usar `{{baseUrl}}` en tus requests.

---

## ?? Agregar Tests Automáticos

### Para verificar automáticamente los resultados:

1. Selecciona una request (ej: CelsiusToFahrenheit)
2. Haz clic en la pestaña **"Tests"**
3. Pega este código:

```javascript
// Test 1: Verificar que la respuesta sea 200 OK
pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});

// Test 2: Verificar que la respuesta contenga XML
pm.test("Response is XML", function () {
    pm.response.to.have.header("Content-Type");
    pm.expect(pm.response.headers.get("Content-Type"))
        .to.include("text/xml");
});

// Test 3: Verificar que contiene el resultado
pm.test("Response contains result", function () {
    pm.expect(pm.response.text())
        .to.include("CelsiusToFahrenheitResult");
});

// Test 4: Verificar el valor específico (para 25°C)
pm.test("25°C equals 77°F", function () {
    var responseText = pm.response.text();
    pm.expect(responseText).to.include(">77<");
});
```

4. Haz clic en **"Send"**
5. Ve la pestaña **"Test Results"** abajo

Deberías ver: **4/4 tests passed** ?

---

## ?? Tabla de Referencia Rápida

### Todos los Métodos Disponibles:

| Categoría | Método | Parámetro | Ejemplo | Resultado |
|-----------|--------|-----------|---------|-----------|
| ??? Temp | CelsiusToFahrenheit | celsius | 25 | 77 |
| ??? Temp | FahrenheitToCelsius | fahrenheit | 77 | 25 |
| ??? Temp | CelsiusToKelvin | celsius | 0 | 273.15 |
| ?? Masa | KilogramsToPounds | kilograms | 10 | 22.0462 |
| ?? Masa | PoundsToKilograms | pounds | 22.0462 | 10 |
| ?? Masa | KilogramsToOunces | kilograms | 1 | 35.274 |
| ?? Long | MetersToFeet | meters | 100 | 328.084 |
| ?? Long | FeetToMeters | feet | 328.084 | 100 |
| ?? Long | KilometersToMiles | kilometers | 10 | 6.21371 |

---

## ? Solución de Problemas en Postman

### Error: "Could not get any response"

**Causa:** El servicio no está ejecutándose

**Solución:**
1. Abre Visual Studio
2. Presiona F5 para ejecutar el servicio
3. Ejecuta `ProbarServicio.bat` para verificar
4. Intenta de nuevo en Postman

---

### Error: 500 Internal Server Error

**Causa:** Error en el formato del XML SOAP

**Solución:**
1. Verifica que el XML esté bien formado (sin errores de sintaxis)
2. Verifica que el SOAPAction header esté correcto
3. Compara tu XML con los ejemplos de la colección

---

### Error: 400 Bad Request

**Causa:** Headers incorrectos

**Solución:**
1. Ve a la pestaña "Headers"
2. Verifica:
   - `Content-Type: text/xml; charset=utf-8`
   - `SOAPAction: "http://tempuri.org/IService/[NombreMetodo]"`
3. Asegúrate de que SOAPAction tenga comillas dobles

---

### No veo el resultado numérico

**Causa:** La respuesta es XML completo

**Solución:**
El resultado está dentro del XML. Busca el elemento:
```xml
<[NombreMetodo]Result>AQUÍ ESTÁ EL NÚMERO</[NombreMetodo]Result>
```

Para extraerlo automáticamente, usa la pestaña "Tests" con código JavaScript.

---

## ?? Video Tutorial (Pasos Visuales)

### Paso 1: Abrir Postman
```
[Inicio] ? [Postman App]
```

### Paso 2: Importar Colección
```
[Import] ? [Upload Files] ? [Seleccionar JSON] ? [Import]
```

### Paso 3: Ejecutar Primera Prueba
```
[Colección] ? [0. Verificar WSDL] ? [Send] ? [Ver Respuesta 200 OK]
```

### Paso 4: Probar Conversión
```
[Temperatura] ? [CelsiusToFahrenheit] ? [Send] ? [Ver Result: 77]
```

### Paso 5: Cambiar Valor
```
[Body] ? [Cambiar 25 por 100] ? [Send] ? [Ver Result: 212]
```

---

## ? Checklist de Verificación

Antes de comenzar las pruebas, verifica:

- [ ] Visual Studio está ejecutándose como administrador
- [ ] El servicio está corriendo (F5 en Visual Studio)
- [ ] La IP 192.168.137.1 está configurada en tu red
- [ ] El firewall permite el puerto 63393
- [ ] Postman está instalado
- [ ] Has importado la colección JSON

Durante las pruebas:

- [ ] La prueba WSDL devuelve 200 OK
- [ ] CelsiusToFahrenheit(25) devuelve 77
- [ ] Todas las conversiones de temperatura funcionan
- [ ] Todas las conversiones de masa funcionan
- [ ] Todas las conversiones de longitud funcionan

---

## ?? Consejos Pro

### 1. Usar Collection Runner
Para probar todos los métodos a la vez:
1. Haz clic en los tres puntos (...) junto a la colección
2. Selecciona **"Run collection"**
3. Haz clic en **"Run WCF Servicio de Conversiones"**
4. Ve todos los resultados en una sola pantalla

### 2. Exportar Resultados
1. Después de ejecutar las pruebas
2. Haz clic en **"Export Results"**
3. Guarda el JSON con los resultados

### 3. Compartir la Colección
1. Haz clic derecho en la colección
2. Selecciona **"Export"**
3. Comparte el archivo JSON con tu equipo

---

¡Listo! Ahora puedes probar tu servicio WCF completamente con Postman. ??
