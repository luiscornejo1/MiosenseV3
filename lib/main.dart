import 'package:flutter/material.dart';
import 'package:miosense/Views/splash_screen.dart';


void main() {
  runApp(MiosenseApp());
}

class MiosenseApp extends StatelessWidget {
  const MiosenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
