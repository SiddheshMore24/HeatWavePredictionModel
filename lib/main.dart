import 'package:climate_resilience_app/src/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
// import 'src/screens/splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Climate Resilience App',
      home: SplashScreen(),
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
    );
  }
}
