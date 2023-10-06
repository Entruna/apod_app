import 'package:apod_app/presentation/widget/side_menu.dart';
import 'package:flutter/material.dart';

///Archive screen
class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Archive Screen')),
      drawer: const SideMenu(),
    );
  }
}
