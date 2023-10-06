import 'package:apod_app/injection.dart';
import 'package:apod_app/presentation/archive_screen.dart';
import 'package:apod_app/presentation/home_screen.dart';
import 'package:apod_app/presentation/routes.dart';
import 'package:flutter/material.dart';

void main() {
  ///Dependency injection set up
  setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.archive: (context) => const ArchiveScreen(),
      },
    );
  }
}
