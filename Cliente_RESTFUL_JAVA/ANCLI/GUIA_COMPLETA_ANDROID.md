# 📱 GUÍA COMPLETA - Cliente Android Monster University

## 🌐 CONFIGURACIÓN DE RED

### ✅ Tu servidor está en:
**IP Local:** `192.168.18.113`
**Puerto:** `8080`

### 📍 URLs según el dispositivo:

#### 1️⃣ Para EMULADOR AVD (Android Studio):
```java
http://10.0.2.2:8080/WS_ConersionUnidades_RESTFULL/webresources/
```
**Nota:** El emulador usa `10.0.2.2` para acceder al localhost de tu PC.

#### 2️⃣ Para DISPOSITIVO FÍSICO (misma WiFi):
```java
http://192.168.18.113:8080/WS_ConersionUnidades_RESTFULL/webresources/
```

#### 3️⃣ Para PROBAR desde el navegador:
```
http://192.168.18.113:8080/WS_ConersionUnidades_RESTFULL/webresources/application.wadl
```

---

## 🎨 TEMA DE COLORES SULLIVAN (YA CONFIGURADO)

### Archivo: `res/values/colors.xml`

**Colores Principales:**
- `sullivan_primary` → #4A90E2 (Azul Sullivan)
- `sullivan_primary_dark` → #2E5C8A (Azul oscuro)
- `sullivan_background` → #E8F4F8 (Fondo azul claro)
- `sullivan_success` → #27AE60 (Verde)
- `sullivan_error` → #E74C3C (Rojo)
- `sullivan_warning` → #FF9800 (Naranja)

---

## 🖼️ IMAGEN DE SULLIVAN CON BORDER RADIUS

### Archivo copiado:
✅ `res/drawable/login_sullivan.jpg`

### Drawable circular creado:
✅ `res/drawable/circular_image_border.xml`

### Cómo usarlo en tu layout:
```xml
<ImageView
    android:id="@+id/imgSullivan"
    android:layout_width="150dp"
    android:layout_height="150dp"
    android:src="@drawable/login_sullivan"
    android:background="@drawable/circular_image_border"
    android:scaleType="centerCrop"
    android:clipToOutline="true"
    android:padding="4dp" />
```

O usar CardView para mejor resultado:
```xml
<androidx.cardview.widget.CardView
    android:layout_width="160dp"
    android:layout_height="160dp"
    app:cardCornerRadius="80dp"
    app:cardElevation="4dp"
    app:cardBackgroundColor="@color/sullivan_primary">
    
    <ImageView
        android:layout_width="150dp"
        android:layout_height="150dp"
        android:layout_gravity="center"
        android:src="@drawable/login_sullivan"
        android:scaleType="centerCrop" />
</androidx.cardview.widget.CardView>
```

---

## 🎯 ARCHIVOS CREADOS Y CONFIGURADOS

### ✅ Colores:
- `res/values/colors.xml` → Paleta completa de Sullivan

### ✅ Drawables (Fondos y Formas):
- `circular_image_border.xml` → Borde circular para la imagen
- `button_primary.xml` → Botón azul Sullivan
- `button_success.xml` → Botón verde
- `button_danger.xml` → Botón rojo
- `edittext_background.xml` → Fondo para campos de texto
- `card_background.xml` → Fondo para tarjetas
- `result_background.xml` → Fondo para resultados

### ✅ Configuración Java:
- `api/ApiConfig.java` → Configuración de URLs y constantes

---

## 📋 PRÓXIMOS PASOS PARA DESARROLLAR

### 1️⃣ Verificar dependencias en `app/build.gradle`:

```gradle
dependencies {
    // Retrofit para peticiones HTTP
    implementation 'com.squareup.retrofit2:retrofit:2.9.0'
    implementation 'com.squareup.retrofit2:converter-gson:2.9.0'
    implementation 'com.squareup.retrofit2:converter-scalars:2.9.0'
    
    // OkHttp
    implementation 'com.squareup.okhttp3:okhttp:4.11.0'
    implementation 'com.squareup.okhttp3:logging-interceptor:4.11.0'
    
    // Material Design
    implementation 'com.google.android.material:material:1.11.0'
    
    // CardView
    implementation 'androidx.cardview:cardview:1.0.0'
}
```

### 2️⃣ Agregar permisos en `AndroidManifest.xml`:

```xml
<manifest>
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
    <application
        android:usesCleartextTraffic="true"
        ...>
    </application>
</manifest>
```

**IMPORTANTE:** `usesCleartextTraffic="true"` es necesario para HTTP (no HTTPS).

### 3️⃣ Crear el servicio Retrofit:

```java
package com.example.andclie.api;

import okhttp3.OkHttpClient;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Retrofit;
import retrofit2.converter.scalars.ScalarsConverterFactory;

import java.util.concurrent.TimeUnit;

public class RetrofitClient {
    
    private static Retrofit retrofit = null;
    
    public static Retrofit getClient() {
        if (retrofit == null) {
            HttpLoggingInterceptor logging = new HttpLoggingInterceptor();
            logging.setLevel(HttpLoggingInterceptor.Level.BODY);
            
            OkHttpClient client = new OkHttpClient.Builder()
                    .addInterceptor(logging)
                    .connectTimeout(ApiConfig.CONNECT_TIMEOUT, TimeUnit.SECONDS)
                    .readTimeout(ApiConfig.READ_TIMEOUT, TimeUnit.SECONDS)
                    .writeTimeout(ApiConfig.WRITE_TIMEOUT, TimeUnit.SECONDS)
                    .build();
            
            retrofit = new Retrofit.Builder()
                    .baseUrl(ApiConfig.BASE_URL)
                    .client(client)
                    .addConverterFactory(ScalarsConverterFactory.create())
                    .build();
        }
        return retrofit;
    }
}
```

### 4️⃣ Crear la interfaz API:

```java
package com.example.andclie.api;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

public interface ConversionApi {
    
    // Longitud
    @GET("conversion/pulgadas-a-cm/{valor}")
    Call<String> pulgadasACm(@Path("valor") double valor);
    
    @GET("conversion/cm-a-pulgadas/{valor}")
    Call<String> cmAPulgadas(@Path("valor") double valor);
    
    @GET("conversion/km-a-m/{valor}")
    Call<String> kmAMetros(@Path("valor") double valor);
    
    @GET("conversion/m-a-cm/{valor}")
    Call<String> metrosACm(@Path("valor") double valor);
    
    @GET("conversion/cm-a-mm/{valor}")
    Call<String> cmAMm(@Path("valor") double valor);
    
    // Temperatura
    @GET("conversion/celsius-a-fahrenheit/{valor}")
    Call<String> celsiusAFahrenheit(@Path("valor") double valor);
    
    @GET("conversion/fahrenheit-a-celsius/{valor}")
    Call<String> fahrenheitACelsius(@Path("valor") double valor);
    
    @GET("conversion/celsius-a-kelvin/{valor}")
    Call<String> celsiusAKelvin(@Path("valor") double valor);
    
    // Masa
    @GET("conversion/kg-a-gramos/{valor}")
    Call<String> kgAGramos(@Path("valor") double valor);
    
    @GET("conversion/gramos-a-miligramos/{valor}")
    Call<String> gramosAMiligramos(@Path("valor") double valor);
    
    @GET("conversion/toneladas-a-kg/{valor}")
    Call<String> toneladasAKg(@Path("valor") double valor);
}
```

---

## 🧪 PROBAR LA CONEXIÓN

### Desde el código Android:

```java
ConversionApi api = RetrofitClient.getClient().create(ConversionApi.class);

api.celsiusAFahrenheit(25).enqueue(new Callback<String>() {
    @Override
    public void onResponse(Call<String> call, Response<String> response) {
        if (response.isSuccessful()) {
            String resultado = response.body();
            Log.d("API", "Resultado: " + resultado);
            // Mostrar en la UI
        }
    }
    
    @Override
    public void onFailure(Call<String> call, Throwable t) {
        Log.e("API", "Error: " + t.getMessage());
    }
});
```

---

## 🔥 VERIFICAR QUE EL SERVIDOR ESTÉ ACTIVO

Antes de probar la app Android, asegúrate de que el servidor Java esté corriendo:

1. Abre NetBeans/IntelliJ
2. Ejecuta el proyecto del servidor
3. Verifica en el navegador: `http://localhost:8080/WS_ConersionUnidades_RESTFULL`
4. Debe aparecer la página de prueba

---

## 🎨 DISEÑO DE LOGIN RECOMENDADO

```xml
<!-- Fondo azul claro Sullivan -->
<LinearLayout
    android:background="@color/sullivan_background">
    
    <!-- Card blanco centrado -->
    <androidx.cardview.widget.CardView
        app:cardBackgroundColor="@color/white"
        app:cardCornerRadius="16dp"
        app:cardElevation="8dp">
        
        <!-- Imagen circular de Sullivan -->
        <androidx.cardview.widget.CardView
            app:cardCornerRadius="80dp">
            <ImageView
                android:src="@drawable/login_sullivan" />
        </androidx.cardview.widget.CardView>
        
        <!-- Título -->
        <TextView
            android:text="🎓 MONSTER UNIVERSITY"
            android:textColor="@color/sullivan_primary_dark"
            android:textSize="20sp"
            android:textStyle="bold" />
        
        <!-- Campos de entrada -->
        <EditText
            android:hint="Usuario"
            android:background="@drawable/edittext_background" />
        
        <EditText
            android:hint="Contraseña"
            android:inputType="textPassword"
            android:background="@drawable/edittext_background" />
        
        <!-- Botón de login -->
        <Button
            android:text="🔓 INGRESAR"
            android:background="@drawable/button_primary"
            android:textColor="@color/white" />
    </androidx.cardview.widget.CardView>
</LinearLayout>
```

---

## ✅ RESUMEN DE LO QUE YA ESTÁ LISTO

✅ Colores de Sullivan configurados
✅ Imagen de Sullivan copiada y lista para usar
✅ Drawables para botones y fondos creados
✅ Configuración de API lista (ApiConfig.java)
✅ URLs configuradas para emulador y dispositivo físico
✅ Servidor con CORS habilitado
✅ IP del servidor identificada: 192.168.18.113

---

## 📞 CONTACTO Y CREDENCIALES

**Usuario:** MONSTER
**Contraseña:** Monster9

---

¡Todo está listo para que comiences a desarrollar tu app Android con el tema de Sullivan! 🎓💙
