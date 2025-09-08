import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Pastikan ini mengarah ke SplashScreen.dart


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Pajak',
      theme: ThemeData(
        // Tema warna baru
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF0F4C81), // Warna biru tua
        scaffoldBackgroundColor: Colors.grey[50], // Latar belakang abu-abu muda
        appBarTheme: const AppBarTheme(
          color: Color(0xFF0F4C81),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0F4C81), // Warna tombol biru tua
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
