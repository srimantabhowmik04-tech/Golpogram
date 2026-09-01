import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/auth/login_screen.dart';
import 'screens/feed/feed_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase init: $e");
  }
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
        primaryColor: const Color(0xFF00897B),
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0.5,
          iconTheme: IconThemeData(color: Color(0xFF00897B)),
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(color: Color(0xFF00897B))),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data!;
            final displayName = user.displayName?.isNotEmpty == true
                ? user.displayName!
                : user.email?.split('@').first ?? 'User';
            return GolpogramFeedScreen(userName: displayName);
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
