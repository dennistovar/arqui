# 🚀 CÓMO EJECUTAR LA APLICACIÓN ANDROID

## ✅ CAMBIOS REALIZADOS

### 1️⃣ Pantallas Creadas:
- ✅ **LoginScreen.kt** - Pantalla de login con imagen circular de Sullivan
- ✅ **ConversionScreen.kt** - Pantalla de conversiones con tema Sullivan
- ✅ **MainActivity.kt** - Actualizado para usar las nuevas pantallas

### 2️⃣ Permisos Agregados:
- ✅ `INTERNET` - Para hacer peticiones HTTP
- ✅ `ACCESS_NETWORK_STATE` - Para verificar conexión
- ✅ `usesCleartextTraffic="true"` - Para permitir HTTP (no HTTPS)

### 3️⃣ Tema Sullivan Aplicado:
- 🎨 Colores azules de Sullivan en toda la app
- 🖼️ Imagen circular con borde en el login
- 💙 Diseño Material 3 con colores personalizados

---

## 🏃 PASOS PARA EJECUTAR

### PASO 1: Verificar que el servidor Java esté corriendo

Abre tu navegador y verifica:
```
http://localhost:8080/WS_ConersionUnidades_RESTFULL
```

Si no está activo, inícialo desde NetBeans/IntelliJ.

---

### PASO 2: Sincronizar el proyecto en Android Studio

1. En Android Studio, haz clic en:
   - **File → Sync Project with Gradle Files**
   
2. Espera a que termine la sincronización (barra de progreso abajo)

---

### PASO 3: Ejecutar la aplicación

#### Opción A: Con el emulador (RECOMENDADO para empezar)

1. **Crear/Iniciar el emulador:**
   - Clic en **Device Manager** (ícono de teléfono en la barra derecha)
   - Si no tienes emulador, haz clic en **Create Device**
   - Selecciona **Phone → Pixel 6** → **Next**
   - Selecciona **API 33** (Tiramisu) → **Next** → **Finish**
   - Haz clic en **▶️** para iniciar el emulador

2. **Ejecutar la app:**
   - Espera a que el emulador termine de cargar
   - Haz clic en el botón **▶️ Run** (o presiona `Shift + F10`)
   - Selecciona el emulador de la lista
   - Espera a que compile e instale

3. **Probar el login:**
   - Usuario: `MONSTER`
   - Contraseña: `Monster9`

---

#### Opción B: Con dispositivo físico

1. **Habilitar opciones de desarrollador en tu teléfono:**
   - Configuración → Acerca del teléfono
   - Toca 7 veces sobre "Número de compilación"
   - Vuelve y entra en "Opciones de desarrollador"
   - Activa "Depuración USB"

2. **Conectar el teléfono por USB**

3. **Cambiar la URL en el código:**
   - Abre: `ConversionScreen.kt`
   - Busca la línea: `val baseUrl = "http://10.0.2.2:8080/..."`
   - Cámbiala por: `val baseUrl = "http://192.168.18.113:8080/..."`

4. **Asegúrate de que tu teléfono y PC estén en la misma red WiFi**

5. **Ejecutar:**
   - Haz clic en **▶️ Run**
   - Selecciona tu dispositivo de la lista

---

## 🧪 PROBAR LA APLICACIÓN

### 1️⃣ Login:
- Ingresa usuario: **MONSTER**
- Ingresa contraseña: **Monster9**
- Haz clic en **🔓 INGRESAR**

### 2️⃣ Hacer una conversión:
1. Selecciona una **Categoría** (Longitud, Temperatura o Masa)
2. Selecciona un **Tipo de Conversión**
3. Ingresa un **Valor** (ejemplo: 25)
4. Haz clic en **✅ CONVERTIR**
5. Verás el resultado en el cuadro verde

### 3️⃣ Probar conversiones:
- **Temperatura:** 25 °C → 77 °F
- **Longitud:** 12 pulgadas → 30.48 cm
- **Masa:** 5 kg → 5000 gramos

---

## ❌ SOLUCIÓN DE PROBLEMAS

### Problema 1: "Error de conexión"
**Solución:**
- Verifica que el servidor Java esté corriendo
- En el emulador, usa: `http://10.0.2.2:8080/...`
- En dispositivo físico, usa: `http://192.168.18.113:8080/...`

### Problema 2: "Build failed" o errores de compilación
**Solución:**
- **Build → Clean Project**
- **Build → Rebuild Project**
- **File → Invalidate Caches / Restart**

### Problema 3: La imagen de Sullivan no se ve
**Solución:**
- Verifica que exista: `app/src/main/res/drawable/login_sullivan.jpg`
- Si no está, cópiala manualmente desde la carpeta ANCLI

### Problema 4: Credenciales incorrectas
**Solución:**
- Usuario debe ser exactamente: `MONSTER` (mayúsculas)
- Contraseña debe ser exactamente: `Monster9` (M mayúscula)

---

## 📝 ATAJOS DE TECLADO ÚTILES

- **Shift + F10** - Ejecutar app
- **Ctrl + F9** - Compilar proyecto
- **Alt + 4** - Abrir panel Run
- **Alt + 6** - Abrir panel Logcat (para ver logs)

---

## 📊 VERIFICAR QUE TODO FUNCIONE

### ✅ Checklist:

1. ¿El servidor Java está corriendo?
2. ¿Android Studio sincronizó correctamente?
3. ¿El emulador/dispositivo está conectado?
4. ¿La app se instaló sin errores?
5. ¿Aparece la pantalla de login con la imagen de Sullivan?
6. ¿Puedes hacer login con MONSTER/Monster9?
7. ¿Aparece la pantalla de conversiones con fondo azul?
8. ¿Las conversiones funcionan correctamente?

Si todos los puntos están en ✅, ¡tu app está funcionando perfectamente! 🎉

---

## 🎨 CARACTERÍSTICAS DE LA APP

### Pantalla de Login:
- 🖼️ Imagen circular de Sullivan con borde azul
- 📱 Card centrado con sombra
- 🔐 Campos de usuario y contraseña
- ✅ Validación de credenciales
- 🎨 Colores azules del tema Sullivan

### Pantalla de Conversiones:
- 🎓 Header azul con título de Monster University
- 📊 Card de configuración con dropdowns
- 🔄 11 tipos de conversiones disponibles
- ✅ Botón verde para convertir
- 🗑️ Botón naranja para limpiar
- 💚 Card verde para mostrar resultados
- 🚪 Botones de cerrar sesión y salir

---

¡Ahora ejecuta la app y disfruta de tu cliente Android con el tema Sullivan! 🎓💙
