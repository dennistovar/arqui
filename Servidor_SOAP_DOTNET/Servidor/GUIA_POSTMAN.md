# ?? Guía de Pruebas con Postman - Servicio WCF

## ?? Configuración Inicial

### URL del Servicio
```
http://192.168.137.1:63393/Service.svc
```

### Importante sobre WCF y Postman
Los servicios WCF usan **SOAP** (protocolo basado en XML), no REST. Postman puede enviar peticiones SOAP, pero necesitas configurarlo correctamente.

---

## ?? Paso 1: Verificar que el Servicio Esté Activo

### Request Básico - Verificar WSDL

**Método:** GET  
**URL:** `http://192.168.137.1:63393/Service.svc?wsdl`

**Headers:** Ninguno necesario

**Respuesta Esperada:** Documento XML con la definición del servicio (WSDL)

---

## ?? Paso 2: Configurar Peticiones SOAP

Para cada método del servicio, necesitas enviar una petición SOAP (XML).

### Estructura General de Petición SOAP

**Método:** POST  
**URL:** `http://192.168.137.1:63393/Service.svc`

**Headers:**
```
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://tempuri.org/IService/[NombreDelMetodo]"
```

**Body:** (selecciona "raw" y "XML")

---

## ??? PRUEBAS DE TEMPERATURA

### 1. CelsiusToFahrenheit

**Método:** POST  
**URL:** `http://192.168.137.1:63393/Service.svc`

**Headers:**
```
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://tempuri.org/IService/CelsiusToFahrenheit"
```

**Body (XML):**
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
  <soap:Body>
    <tem:CelsiusToFahrenheit>
      <tem:celsius>25</tem:celsius>
    </tem:CelsiusToFahrenheit>
  </soap:Body>
</soap:Envelope>
```

**Respuesta Esperada:**
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

---

### 2. FahrenheitToCelsius

**Método:** POST  
**URL:** `http://192.168.137.1:63393/Service.svc`

**Headers:**
```
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://tempuri.org/IService/FahrenheitToCelsius"
```

**Body (XML):**
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
  <soap:Body>
    <tem:FahrenheitToCelsius>
      <tem:fahrenheit>77</tem:fahrenheit>
    </tem:FahrenheitToCelsius>
  </soap:Body>
</soap:Envelope>
```

**Resultado Esperado:** `25`

---

### 3. CelsiusToKelvin

**Método:** POST  
**URL:** `http://192.168.137.1:63393/Service.svc`

**Headers:**
```
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://tempuri.org/IService/CelsiusToKelvin"
```

**Body (XML):**
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
  <soap:Body>
    <tem:CelsiusToKelvin>
      <tem:celsius>0</tem:celsius>
    </tem:CelsiusToKelvin>
  </soap:Body>
</soap:Envelope>
```

**Resultado Esperado:** `273.15`

---

## ?? PRUEBAS DE MASA

### 4. KilogramsToPounds

**Método:** POST  
**URL:** `http://192.168.137.1:63393/Service.svc`

**Headers:**
```
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://tempuri.org/IService/KilogramsToPounds"
```

**Body (XML):**
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
  <soap:Body>
    <tem:KilogramsToPounds>
      <tem:kilograms>10</tem:kilograms>
    </tem:KilogramsToPounds>
  </soap:Body>
</soap:Envelope>
```

**Resultado Esperado:** `22.0462`

---

### 5. PoundsToKilograms

**Método:** POST  
**URL:** `http://192.168.137.1:63393/Service.svc`

**Headers:**
```
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://tempuri.org/IService/PoundsToKilograms"
```

**Body (XML):**
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
  <soap:Body>
    <tem:PoundsToKilograms>
      <tem:pounds>22.0462</tem:pounds>
    </tem:PoundsToKilograms>
  </soap:Body>
</soap:Envelope>
```

**Resultado Esperado:** `10`

---

### 6. KilogramsToOunces

**Método:** POST  
**URL:** `http://192.168.137.1:63393/Service.svc`

**Headers:**
```
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://tempuri.org/IService/KilogramsToOunces"
```

**Body (XML):**
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
  <soap:Body>
    <tem:KilogramsToOunces>
      <tem:kilograms>1</tem:kilograms>
    </tem:KilogramsToOunces>
  </soap:Body>
</soap:Envelope>
```

**Resultado Esperado:** `35.274`

---

## ?? PRUEBAS DE LONGITUD

### 7. MetersToFeet

**Método:** POST  
**URL:** `http://192.168.137.1:63393/Service.svc`

**Headers:**
```
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://tempuri.org/IService/MetersToFeet"
```

**Body (XML):**
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
  <soap:Body>
    <tem:MetersToFeet>
      <tem:meters>100</tem:meters>
    </tem:MetersToFeet>
  </soap:Body>
</soap:Envelope>
```

**Resultado Esperado:** `328.084`

---

### 8. FeetToMeters

**Método:** POST  
**URL:** `http://192.168.137.1:63393/Service.svc`

**Headers:**
```
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://tempuri.org/IService/FeetToMeters"
```

**Body (XML):**
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
  <soap:Body>
    <tem:FeetToMeters>
      <tem:feet>328.084</tem:feet>
    </tem:FeetToMeters>
  </soap:Body>
</soap:Envelope>
```

**Resultado Esperado:** `100`

---

### 9. KilometersToMiles

**Método:** POST  
**URL:** `http://192.168.137.1:63393/Service.svc`

**Headers:**
```
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://tempuri.org/IService/KilometersToMiles"
```

**Body (XML):**
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
  <soap:Body>
    <tem:KilometersToMiles>
      <tem:kilometers>10</tem:kilometers>
    </tem:KilometersToMiles>
  </soap:Body>
</soap:Envelope>
```

**Resultado Esperado:** `6.21371`

---

## ?? Configuración en Postman - Paso a Paso

### 1. Crear una Nueva Request

1. Abre Postman
2. Clic en "New" ? "Request"
3. Dale un nombre: "CelsiusToFahrenheit"
4. Crea una colección: "WCF Conversiones"

### 2. Configurar el Método y URL

1. Selecciona **POST** en el dropdown
2. URL: `http://192.168.137.1:63393/Service.svc`

### 3. Configurar Headers

Clic en la pestaña "Headers" y agrega:

| Key | Value |
|-----|-------|
| Content-Type | text/xml; charset=utf-8 |
| SOAPAction | "http://tempuri.org/IService/CelsiusToFahrenheit" |

### 4. Configurar Body

1. Clic en la pestaña "Body"
2. Selecciona **raw**
3. En el dropdown de la derecha, selecciona **XML**
4. Pega el XML del body correspondiente

### 5. Enviar Request

1. Clic en "Send"
2. Verifica la respuesta en la sección de abajo

---

## ?? Colección de Postman

He creado una colección completa que puedes importar. Busca el archivo:
```
WCF_Conversiones_Postman_Collection.json
```

### Importar la Colección:

1. Abre Postman
2. Clic en "Import" (arriba a la izquierda)
3. Arrastra el archivo JSON o selecciónalo
4. La colección aparecerá en el panel izquierdo

---

## ?? Tips para Postman

### Variables de Entorno

Puedes crear variables para no repetir la URL:

1. Clic en el ícono de ojo (arriba a la derecha) ? "Add"
2. Crea un Environment: "WCF Local"
3. Agrega variables:
   - `baseUrl`: `http://192.168.137.1:63393/Service.svc`
   - `namespace`: `http://tempuri.org/`

Usa las variables en tus requests:
```
URL: {{baseUrl}}
SOAPAction: "{{namespace}}IService/CelsiusToFahrenheit"
```

### Tests Automáticos

Puedes agregar tests en la pestaña "Tests":

```javascript
pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});

pm.test("Response contains result", function () {
    pm.expect(pm.response.text()).to.include("Result");
});
```

### Extraer el Resultado

Para ver solo el valor numérico en los tests:

```javascript
const responseXml = xml2Json(responseBody);
const result = responseXml.Envelope.Body.CelsiusToFahrenheitResponse.CelsiusToFahrenheitResult;
console.log("Resultado:", result);

pm.test("El resultado es 77", function () {
    pm.expect(parseFloat(result)).to.equal(77);
});
```

---

## ?? Solución de Problemas

### Error: "Could not connect to server"

**Causa:** El servicio no está ejecutándose o la IP es incorrecta

**Solución:**
1. Verifica que Visual Studio esté ejecutándose con F5
2. Ejecuta `ProbarServicio.bat` para verificar conectividad
3. Verifica que la IP 192.168.137.1 esté configurada

### Error: "500 Internal Server Error"

**Causa:** Error en el formato del XML SOAP

**Solución:**
1. Verifica que el XML esté bien formado
2. Verifica que el SOAPAction sea correcto
3. Verifica que el namespace sea `http://tempuri.org/`

### Error: "Action not found"

**Causa:** El SOAPAction header está mal configurado

**Solución:**
Asegúrate de que el SOAPAction sea exactamente:
```
"http://tempuri.org/IService/[NombreDelMetodo]"
```
(con las comillas incluidas)

### No veo el resultado numérico

**Causa:** La respuesta es XML

**Solución:**
El resultado está dentro del XML de respuesta. Busca el elemento `[NombreMetodo]Result`.

---

## ?? Tabla de Resumen de Pruebas

| # | Método | Input | Output Esperado | SOAPAction |
|---|--------|-------|-----------------|------------|
| 1 | CelsiusToFahrenheit | 25 | 77 | http://tempuri.org/IService/CelsiusToFahrenheit |
| 2 | FahrenheitToCelsius | 77 | 25 | http://tempuri.org/IService/FahrenheitToCelsius |
| 3 | CelsiusToKelvin | 0 | 273.15 | http://tempuri.org/IService/CelsiusToKelvin |
| 4 | KilogramsToPounds | 10 | 22.0462 | http://tempuri.org/IService/KilogramsToPounds |
| 5 | PoundsToKilograms | 22.0462 | 10 | http://tempuri.org/IService/PoundsToKilograms |
| 6 | KilogramsToOunces | 1 | 35.274 | http://tempuri.org/IService/KilogramsToOunces |
| 7 | MetersToFeet | 100 | 328.084 | http://tempuri.org/IService/MetersToFeet |
| 8 | FeetToMeters | 328.084 | 100 | http://tempuri.org/IService/FeetToMeters |
| 9 | KilometersToMiles | 10 | 6.21371 | http://tempuri.org/IService/KilometersToMiles |

---

## ? Checklist de Pruebas

- [ ] WSDL accesible (GET http://192.168.137.1:63393/Service.svc?wsdl)
- [ ] CelsiusToFahrenheit(25) ? 77
- [ ] FahrenheitToCelsius(77) ? 25
- [ ] CelsiusToKelvin(0) ? 273.15
- [ ] KilogramsToPounds(10) ? 22.0462
- [ ] PoundsToKilograms(22.0462) ? 10
- [ ] KilogramsToOunces(1) ? 35.274
- [ ] MetersToFeet(100) ? 328.084
- [ ] FeetToMeters(328.084) ? 100
- [ ] KilometersToMiles(10) ? 6.21371

---

¡Listo! Ahora puedes probar tu servicio WCF con Postman siguiendo esta guía. ??
