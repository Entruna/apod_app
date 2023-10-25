import 'package:apod_app/constants/constants.dart';
import 'package:flutter/material.dart';

class ImageErrorWidget extends StatelessWidget {
  final Color color;
  const ImageErrorWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Icon(Icons.error, color: color,), Text(StringConstants.noImageFound, style: TextStyle(color: color, fontSize: 18))],
      ),
    );
  }
}
