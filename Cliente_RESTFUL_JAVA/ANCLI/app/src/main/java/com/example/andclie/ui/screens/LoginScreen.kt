package com.example.andclie.ui.screens

import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.andclie.R

// Colores del tema Sullivan
val SullivanPrimary = Color(0xFF4A90E2)
val SullivanPrimaryDark = Color(0xFF2E5C8A)
val SullivanBackground = Color(0xFFE8F4F8)
val SullivanCardBackground = Color(0xFFFFFFFF)
val SullivanTextPrimary = Color(0xFF1E3A5F)
val SullivanError = Color(0xFFE74C3C)

@Composable
fun LoginScreen(
    onLoginSuccess: () -> Unit
) {
    var username by remember { mutableStateOf("") }
    var password by remember { mutableStateOf("") }
    var errorMessage by remember { mutableStateOf("") }
    var showError by remember { mutableStateOf(false) }

    Box(
        modifier = Modifier.fillMaxSize()
    ) {
        // Imagen de fondo Sullivan y Wasauski
        Image(
            painter = painterResource(id = R.drawable.background_sullivan),
            contentDescription = "Sullivan y Wasauski",
            modifier = Modifier
                .fillMaxSize()
                .alpha(0.3f),
            contentScale = ContentScale.Crop
        )
        
        // Capa semitransparente sobre el fondo
        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(SullivanBackground.copy(alpha = 0.7f)),
            contentAlignment = Alignment.Center
        ) {
            Card(
                modifier = Modifier
                    .fillMaxWidth(0.9f)
                    .wrapContentHeight(),
                shape = RoundedCornerShape(16.dp),
                colors = CardDefaults.cardColors(containerColor = SullivanCardBackground),
                elevation = CardDefaults.cardElevation(defaultElevation = 8.dp)
            ) {
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(32.dp),
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.spacedBy(16.dp)
                ) {
                    // Título principal
                    Text(
                        text = "🎓 MONSTERS UNIVERSITY",
                        fontSize = 20.sp,
                        fontWeight = FontWeight.Bold,
                        color = SullivanPrimaryDark,
                        textAlign = TextAlign.Center
                    )

                    Text(
                        text = "Conversiones de Unidades",
                        fontSize = 14.sp,
                        color = Color.Gray,
                        textAlign = TextAlign.Center
                    )

                    Spacer(modifier = Modifier.height(16.dp))

                    // Campo Usuario
                    OutlinedTextField(
                        value = username,
                        onValueChange = { username = it },
                        label = { Text("👤 Usuario") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        colors = OutlinedTextFieldDefaults.colors(
                            focusedBorderColor = SullivanPrimary,
                            unfocusedBorderColor = Color.LightGray
                        ),
                        shape = RoundedCornerShape(12.dp)
                    )

                    // Campo Contraseña
                    OutlinedTextField(
                        value = password,
                        onValueChange = { password = it },
                        label = { Text("🔒 Contraseña") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        visualTransformation = PasswordVisualTransformation(),
                        colors = OutlinedTextFieldDefaults.colors(
                            focusedBorderColor = SullivanPrimary,
                            unfocusedBorderColor = Color.LightGray
                        ),
                        shape = RoundedCornerShape(12.dp)
                    )

                    // Mensaje de error
                    if (showError) {
                        Text(
                            text = errorMessage,
                            color = SullivanError,
                            fontSize = 12.sp,
                            textAlign = TextAlign.Center
                        )
                    }

                    Spacer(modifier = Modifier.height(8.dp))

                    // Botón Ingresar
                    Button(
                        onClick = {
                            if (username == "MONSTER" && password == "Monster9") {
                                showError = false
                                onLoginSuccess()
                            } else {
                                showError = true
                                errorMessage = "❌ Credenciales incorrectas"
                            }
                        },
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(50.dp),
                        colors = ButtonDefaults.buttonColors(containerColor = SullivanPrimary),
                        shape = RoundedCornerShape(8.dp)
                    ) {
                        Text(
                            text = "🔓 INGRESAR",
                            fontSize = 14.sp,
                            fontWeight = FontWeight.Bold
                        )
                    }

                    // Footer
                    Text(
                        text = "💡 Credenciales: MONSTER / Monster9",
                        fontSize = 10.sp,
                        color = Color.Gray,
                        textAlign = TextAlign.Center,
                        modifier = Modifier.padding(top = 8.dp)
                    )
                }
            }
        }
    }
}
