import 'package:flutter/material.dart';
import 'dart:io';

class DisplaypictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplaypictureScreen({Key? key, required this.imagePath})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display the Picture'),
      ),
    );
  }
}
