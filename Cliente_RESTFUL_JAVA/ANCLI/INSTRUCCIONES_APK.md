# ✅ APK GENERADA CORRECTAMENTE - Monster University

## 📱 INFORMACIÓN DE LA APK

- **Ubicación:** `app\build\outputs\apk\debug\app-debug.apk`
- **Tamaño:** ~9.5 MB
- **Fecha de compilación:** 7 de noviembre de 2025
- **URL del servidor configurada:** `http://192.168.137.1:8080/WS_ConersionUnidades_RESTFULL/webresources`

---

## 🎯 CAMBIOS REALIZADOS

✅ **URL actualizada** a: `http://192.168.137.1:8080/WS_ConersionUnidades_RESTFULL/webresources`
✅ **APK compilada** exitosamente
✅ **Tema Sullivan** aplicado (azules característicos)
✅ **Login funcional** con credenciales MONSTER/Monster9
✅ **11 conversiones** disponibles (Longitud, Temperatura, Masa)

---

## 📲 CÓMO INSTALAR LA APK

### Opción 1: Transferir por cable USB

1. **Conecta tu teléfono Android a la PC**
2. **Copia el archivo:**
   - Origen: `c:\ARQUITECTURA\TI1.3 RESTFUL_JAVA_SINBDD_GRO#5\ANCLI\app\build\outputs\apk\debug\app-debug.apk`
   - Destino: Carpeta "Descargas" de tu teléfono
3. **En el teléfono:**
   - Abre "Archivos" o "Mis Archivos"
   - Ve a "Descargas"
   - Toca `app-debug.apk`
   - Si aparece advertencia de "Fuentes desconocidas", actívala temporalmente
   - Toca "Instalar"

### Opción 2: Enviar por WhatsApp/Telegram a ti mismo

1. **Abre WhatsApp Web o Telegram Desktop**
2. **Envíate el archivo** `app-debug.apk`
3. **En el teléfono:**
   - Descarga el archivo
   - Ábrelo desde WhatsApp/Telegram
   - Permite instalación de fuentes desconocidas si lo pide
   - Toca "Instalar"

### Opción 3: Usar Android Debug Bridge (ADB)

```powershell
# Si tienes ADB instalado:
adb install "c:\ARQUITECTURA\TI1.3 RESTFUL_JAVA_SINBDD_GRO#5\ANCLI\app\build\outputs\apk\debug\app-debug.apk"
```

---

## 🚀 CÓMO USAR LA APLICACIÓN

### 1️⃣ **PREPARAR EL SERVIDOR**

Antes de usar la app, asegúrate de que el servidor Java esté corriendo:

```powershell
# Verifica que el servidor esté activo desde tu PC:
curl http://192.168.137.1:8080/WS_ConersionUnidades_RESTFULL/webresources/application.wadl
```

Si no responde, inicia el servidor Java desde NetBeans/IntelliJ.

### 2️⃣ **CONECTAR EL TELÉFONO A LA MISMA RED**

**IMPORTANTE:** Tu teléfono y PC deben estar en la misma red WiFi.

- **IP del servidor:** 192.168.137.1
- **Puerto:** 8080
- **Red:** Asegúrate de que ambos dispositivos estén conectados al mismo WiFi

### 3️⃣ **ABRIR LA APP**

1. Busca el ícono "ANDCLIE" en tu teléfono
2. Ábrelo
3. Verás la pantalla de login con el tema azul Sullivan

### 4️⃣ **INICIAR SESIÓN**

- **Usuario:** `MONSTER`
- **Contraseña:** `Monster9`
- Toca el botón **🔓 INGRESAR**

### 5️⃣ **REALIZAR UNA CONVERSIÓN**

1. **Selecciona una Categoría:**
   - Longitud
   - Temperatura
   - Masa

2. **Selecciona el Tipo de Conversión:**
   - Ejemplo: "Celsius → Fahrenheit"

3. **Ingresa el valor:**
   - Ejemplo: `25`

4. **Toca CONVERTIR:**
   - Verás el resultado en el cuadro verde
   - Ejemplo: "✅ 25 → 77.0000"

---

## 🧪 PRUEBAS RECOMENDADAS

### Prueba 1: Temperatura
- **Conversión:** Celsius → Fahrenheit
- **Valor:** 25
- **Resultado esperado:** 77.0

### Prueba 2: Longitud
- **Conversión:** Kilómetros → Metros
- **Valor:** 5
- **Resultado esperado:** 5000.0

### Prueba 3: Masa
- **Conversión:** Kilogramos → Gramos
- **Valor:** 3
- **Resultado esperado:** 3000.0

---

## ❌ SOLUCIÓN DE PROBLEMAS

### Problema: "Error de conexión"

**Solución:**
1. Verifica que el servidor Java esté corriendo
2. Confirma que PC y teléfono estén en la misma red WiFi
3. Verifica la IP del servidor:
   ```powershell
   ipconfig | findstr "IPv4"
   ```
4. Si la IP cambió, necesitarás recompilar la APK con la nueva IP

### Problema: "No se puede instalar la app"

**Solución:**
1. Ve a **Configuración → Seguridad**
2. Activa **"Fuentes desconocidas"** o **"Instalar apps desconocidas"**
3. Intenta instalar nuevamente

### Problema: La conversión no funciona

**Solución:**
1. Verifica que ingresaste un número válido
2. Comprueba que seleccionaste categoría y tipo de conversión
3. Revisa que el servidor responda:
   ```
   http://192.168.137.1:8080/WS_ConersionUnidades_RESTFULL/webresources/application.wadl
   ```

---

## 📊 CONVERSIONES DISPONIBLES

### 🔷 Longitud:
- Kilómetros → Metros
- Metros → Centímetros
- Centímetros → Milímetros

### 🌡️ Temperatura:
- Celsius → Fahrenheit
- Fahrenheit → Celsius
- Celsius → Kelvin

### ⚖️ Masa:
- Kilogramos → Gramos
- Gramos → Miligramos
- Toneladas → Kilogramos

---

## 🎨 CARACTERÍSTICAS DE LA APP

✨ **Diseño:**
- Tema azul Sullivan de Monster University
- Imagen de fondo con Sullivan
- Interfaz Material Design 3
- Tarjetas con sombras y bordes redondeados

🔐 **Seguridad:**
- Login con credenciales
- Validación de campos
- Mensajes de error claros

🚀 **Funcionalidad:**
- 11 conversiones diferentes
- Resultados precisos (4 decimales)
- Indicador de carga durante conversión
- Botón de limpiar campos
- Cerrar sesión

---

## 🔄 SI NECESITAS CAMBIAR LA URL DEL SERVIDOR

Si tu IP cambió y necesitas una nueva APK:

1. **Edita el archivo:**
   ```
   app\src\main\java\com\example\andclie\ui\screens\ConversionScreen.kt
   ```

2. **Busca la línea 352:**
   ```kotlin
   val baseUrl = "http://192.168.137.1:8080/WS_ConersionUnidades_RESTFULL/webresources"
   ```

3. **Cámbiala por tu nueva IP:**
   ```kotlin
   val baseUrl = "http://TU_NUEVA_IP:8080/WS_ConersionUnidades_RESTFULL/webresources"
   ```

4. **Recompila la APK:**
   ```powershell
   $env:JAVA_HOME="C:\Program Files\Java\jdk-17"
   cd "c:\ARQUITECTURA\TI1.3 RESTFUL_JAVA_SINBDD_GRO#5\ANCLI"
   .\gradlew.bat clean assembleDebug
   ```

---

## 📞 CREDENCIALES DE ACCESO

- **Usuario:** MONSTER
- **Contraseña:** Monster9

---

## ✅ RESUMEN

✅ APK generada en: `app\build\outputs\apk\debug\app-debug.apk`
✅ Tamaño: ~9.5 MB
✅ URL configurada: http://192.168.137.1:8080/WS_ConersionUnidades_RESTFULL/webresources
✅ Tema Sullivan aplicado
✅ 11 conversiones funcionales
✅ Login operativo
✅ Lista para instalar y probar

---

🎓 **¡Aplicación Monster University lista para usar!** 💙
