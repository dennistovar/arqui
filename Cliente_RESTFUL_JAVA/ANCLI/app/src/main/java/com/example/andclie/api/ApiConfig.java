package com.example.andclie.api;

/**
 * Configuración de la API RESTful
 * Monster University - Sistema de Conversión de Unidades
 */
public class ApiConfig {
    
    // ========== CONFIGURACIÓN DE RED ==========
    
    /**
     * URL para el emulador AVD de Android Studio
     * 10.0.2.2 es la IP especial que el emulador usa para referirse al localhost de la PC
     */
    public static final String BASE_URL_EMULATOR = "http://10.0.2.2:8080/WS_ConersionUnidades_RESTFULL/webresources/";
    
    /**
     * URL para dispositivo físico en la misma red WiFi
     * Usar la IP local de tu PC
     */
    public static final String BASE_URL_DEVICE = "http://192.168.18.113:8080/WS_ConersionUnidades_RESTFULL/webresources/";
    
    /**
     * URL base actual (cambiar según donde ejecutes la app)
     * Por defecto: EMULATOR
     */
    public static final String BASE_URL = BASE_URL_EMULATOR;
    
    // ========== CREDENCIALES ==========
    
    public static final String USERNAME = "MONSTER";
    public static final String PASSWORD = "Monster9";
    
    // ========== ENDPOINTS DE CONVERSIÓN ==========
    
    // Longitud
    public static final String PULGADAS_A_CM = "conversion/pulgadas-a-cm/";
    public static final String CM_A_PULGADAS = "conversion/cm-a-pulgadas/";
    public static final String KM_A_M = "conversion/km-a-m/";
    public static final String M_A_CM = "conversion/m-a-cm/";
    public static final String CM_A_MM = "conversion/cm-a-mm/";
    
    // Temperatura
    public static final String CELSIUS_A_FAHRENHEIT = "conversion/celsius-a-fahrenheit/";
    public static final String FAHRENHEIT_A_CELSIUS = "conversion/fahrenheit-a-celsius/";
    public static final String CELSIUS_A_KELVIN = "conversion/celsius-a-kelvin/";
    
    // Masa
    public static final String KG_A_GRAMOS = "conversion/kg-a-gramos/";
    public static final String GRAMOS_A_MILIGRAMOS = "conversion/gramos-a-miligramos/";
    public static final String TONELADAS_A_KG = "conversion/toneladas-a-kg/";
    
    // ========== TIMEOUT ==========
    
    public static final int CONNECT_TIMEOUT = 30; // segundos
    public static final int READ_TIMEOUT = 30; // segundos
    public static final int WRITE_TIMEOUT = 30; // segundos
    
}
