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
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/ss.jpg',
                width: 100.00,
                height: 300.0,
                fit:BoxFit.cover,
              ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Text(
            'Nexon Apps',
            style:TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),    
    );
  }
}
