import 'package:flutter/material.dart';
///[Loading] widget
class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: Colors.white,));
  }
}
