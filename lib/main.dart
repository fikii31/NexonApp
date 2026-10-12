import 'package:flutter/material.dart';
import 'package:my_firtsapp/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     title: 'Nexon Mobile App',
     theme: ThemeData(
      primarySwatch: Colors.deepPurple,
     ),
     home: SplashScreen(),
    );
  }
}
