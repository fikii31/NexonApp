import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_firtsapp/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    starSplashScreen();
  }

  starSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, (){
     Navigator.of(context).pushReplacement(
       MaterialPageRoute(builder: (context) => MyApp()),
     );
   });
  }
  

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Mengisi seluruh area layar
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/NexonLogo.jpg'), // Path gambar kamu
            fit: BoxFit.cover, // Memastikan gambar memenuhi seluruh layar
          ),
        ),
      ),
    );
  }
}
  
