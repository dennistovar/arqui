# 📱 Cliente Android - Monster University

## 🎨 Tema de Colores Sullivan

Basado en los colores azules del personaje Sullivan de Monsters University:

### Paleta de Colores Principal:
- **Primary Blue:** `#4A90E2` - Azul principal de Sullivan
- **Dark Blue:** `#2E5C8A` - Azul oscuro para títulos
- **Light Blue:** `#E8F4F8` - Fondo claro azulado
- **Accent Blue:** `#64B5F6` - Azul claro para detalles
- **Sky Blue:** `#B3D9F2` - Azul cielo suave

### Colores Secundarios:
- **Success Green:** `#27AE60`
- **Warning Orange:** `#FF9800`
- **Error Red:** `#E74C3C`
- **White:** `#FFFFFF`
- **Text Dark:** `#1E3A5F`

## 🌐 Configuración de Red

### Para Emulador AVD (Android Studio):
```java
private static final String BASE_URL = "http://10.0.2.2:8080/WS_ConersionUnidades_RESTFULL/webresources";
```

### Para Dispositivo Físico (misma WiFi):
```java
private static final String BASE_URL = "http://192.168.18.113:8080/WS_ConersionUnidades_RESTFULL/webresources";
```

## 🖼️ Imagen de Login

La imagen `login-solivan.jpeg` debe:
- Mostrarse de forma circular (border radius)
- Tamaño recomendado: 150dp x 150dp
- Borde azul (#4A90E2) de 3dp

## 🔐 Credenciales

- **Usuario:** MONSTER
- **Contraseña:** Monster9

## 📋 Endpoints Disponibles

### Longitud:
- `/conversion/pulgadas-a-cm/{valor}`
- `/conversion/cm-a-pulgadas/{valor}`
- `/conversion/km-a-m/{valor}`
- `/conversion/m-a-cm/{valor}`
- `/conversion/cm-a-mm/{valor}`

### Temperatura:
- `/conversion/celsius-a-fahrenheit/{valor}`
- `/conversion/fahrenheit-a-celsius/{valor}`
- `/conversion/celsius-a-kelvin/{valor}`

### Masa:
- `/conversion/kg-a-gramos/{valor}`
- `/conversion/gramos-a-miligramos/{valor}`
- `/conversion/toneladas-a-kg/{valor}`

## 📦 Dependencias Necesarias

Agregar en `app/build.gradle`:

```gradle
dependencies {
    // Retrofit para peticiones HTTP
    implementation 'com.squareup.retrofit2:retrofit:2.9.0'
    implementation 'com.squareup.retrofit2:converter-gson:2.9.0'
    
    // OkHttp para logging
    implementation 'com.squareup.okhttp3:logging-interceptor:4.11.0'
    
    // Glide para manejo de imágenes
    implementation 'com.github.bumptech.glide:glide:4.16.0'
    
    // Material Design
    implementation 'com.google.android.material:material:1.11.0'
    
    // ViewModel y LiveData
    implementation 'androidx.lifecycle:lifecycle-viewmodel-ktx:2.7.0'
    implementation 'androidx.lifecycle:lifecycle-livedata-ktx:2.7.0'
}
```

## 🔒 Permisos en AndroidManifest.xml

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

## 🎯 Próximos Pasos

1. ✅ Configurar colors.xml con la paleta Sullivan
2. ✅ Crear layout de login con imagen circular
3. ✅ Implementar Retrofit para las peticiones
4. ✅ Crear layouts para las conversiones
5. ✅ Aplicar tema de colores en toda la app
