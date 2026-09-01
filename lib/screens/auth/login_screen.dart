import 'package:flutter/material.dart';
import '../feed/feed_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ব্যবহারকারীর নাম এবং পাসওয়ার্ড দিন')),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GolpogramFeedScreen(userName: username),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00897B),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.menu_book_rounded, size: 45, color: Colors.white),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Golpogram',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF00897B),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                const Text('গল্প ও ভাবনার সহজ ঠিকানা', style: TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 30),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'লগইন করুন',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 18),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'ইউজারনেম বা ইমেল',
                            prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF00897B)),
                            filled: true,
                            fillColor: const Color(0xFFF4F6F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'পাসওয়ার্ড',
                            prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF00897B)),
                            filled: true,
                            fillColor: const Color(0xFFF4F6F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00897B),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: _handleLogin,
                          child: const Text('প্রবেশ করুন', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignupScreen()),
                            );
                          },
                          child: const Text(
                            'নতুন অ্যাকাউন্ট তৈরি করবেন? সাইন আপ করুন',
                            style: TextStyle(color: Color(0xFF00897B), fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
