import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

class SignupTipService {
  Future<String> getSignupTip() async {
    await Future.delayed(const Duration(milliseconds: 700));

    return 'Mock tip: you should use a long password to avoid getting hacked.';
  }
}

void main() {
  runApp(const MyApp());
}

// 🧓 Great-Grandparent
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fun Signup App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // 🔑 The Global Key - acts like a remote control for the form
  final _formKey = GlobalKey<FormState>();
  
  // 📝 Controllers to track what the user types
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  final _tipService = SignupTipService();
  bool _loadingTip = false;
  String? _tip;
  String? _tipError;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( // 👨 Parent
      appBar: AppBar(
        title: const Text('Join Us Today for the Cash Money!'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form( // 👶 Child
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Create Your Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              
              // 👤 Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),


              // 📧 Email Field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // 🔒 Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              
              // 🚀 Sign Up Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Demo signup complete — your form passed validation!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(
                  'Sign Up',
                  style: const TextStyle(fontSize: 18),
                ),
              ),

              OutlinedButton(
               onPressed: _loadingTip ? null : () async {
                 setState(() {
                  _loadingTip = true;
                  _tip = null;
                   _tipError = null;
                 });

                 try {
                   final result = await _tipService.getSignupTip();
                 if (!mounted) return;

                 setState(() {
                  _tip = result.length > 240
                  ? result.substring(0, 240)
                  : result;
                  _loadingTip = false;
                 });
                } catch (_) {
                 if (!mounted) return;
                 setState(() {
                 _tipError = 'Could not get a tip. Please try again.';
                  _loadingTip = false;
                 });
               }
              },
              child: Text(_loadingTip ? 'Loading...' : 'Get a signup tip'),
               ),

              if (_loadingTip)
                const CircularProgressIndicator(),

              if (_tip != null)
                Text('Mock advice (no live AI): $_tip'),
 
              if (_tipError != null)
                 TextButton(
                 onPressed: () {
                 setState(() {});
                 },
                 child: const Text('Try again'),
                 ),
            ],
          ),
        ),
      ),
    );
  }
}