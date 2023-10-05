import 'package:apod_app/injection.dart';
import 'package:apod_app/presentation/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  ///Dependency injection setup
  setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
