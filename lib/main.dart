import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:plugin/red_text_widget.dart';
import 'package:plugin/widget/takePicture_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: TakepictureScreen(camera: firstCamera),
    debugShowCheckedModeBanner: false,
  ));

  // final secondCamera = cameras.last;
}
