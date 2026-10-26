import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'main_navigation.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:const EdgeInsets.all(24.0) ,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text (
                'Selamat Datang',
                style: 
                TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder()
                ),
                validator: (val) => val == null || val.isEmpty ? 'Masukan email' : null,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration:  const InputDecoration(
                  labelText: 'Kata Sandi',
                  border: OutlineInputBorder()
                ),
                validator: (val) => val == null || val.isEmpty ? 'Masukan kata sandi' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()){
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => const MainNavigation()),
                      );
                  }
                }, 
                child: const Text('Masuk'),
              ),
              TextButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> const RegisterScreen()),
                );
              }, 
              child: const Text('Belum punya akun ? Daftar'),
              )
            ]
          ),
        ),
      ),
    );
  }
}

