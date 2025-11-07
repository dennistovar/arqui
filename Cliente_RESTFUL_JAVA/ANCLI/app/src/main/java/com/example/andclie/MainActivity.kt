package com.example.andclie

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.runtime.*
import com.example.andclie.ui.screens.LoginScreen
import com.example.andclie.ui.screens.ConversionScreen
import com.example.andclie.ui.theme.ANDCLIETheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            ANDCLIETheme {
                MonsterUniversityApp()
            }
        }
    }
}

@Composable
fun MonsterUniversityApp() {
    var isLoggedIn by remember { mutableStateOf(false) }

    if (isLoggedIn) {
        ConversionScreen(
            onLogout = { isLoggedIn = false }
        )
    } else {
        LoginScreen(
            onLoginSuccess = { isLoggedIn = true }
        )
    }
}
