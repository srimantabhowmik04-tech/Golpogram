import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart'; // এই ফাইলটি আমরা পরের ধাপে বানাবো

void main() {
  runApp(const GolpogramApp());
}

class GolpogramApp extends StatelessWidget {
  const GolpogramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Golpogram',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF00897B), // Teal Green Color
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0.5,
          iconTheme: IconThemeData(color: Color(0xFF00897B)),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
