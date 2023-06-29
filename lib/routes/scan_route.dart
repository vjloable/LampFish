import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:lampfish/assets/palette/palette.dart';
import 'package:lampfish/routes/home_route.dart';
import 'package:lampfish/routes/scanned_route.dart';

class ScanRoute extends StatefulWidget {
  const ScanRoute({
    super.key,
    required this.camera,
  });
  final CameraDescription camera;

  @override
  ScanRouteState createState() => ScanRouteState();
}

class ScanRouteState extends State<ScanRoute> {
  late CameraController _controllerCamera;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controllerCamera = CameraController(
      widget.camera,
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.nv21,
    );
    _initializeControllerFuture = _controllerCamera.initialize();
  }

  @override
  void dispose() {
    _controllerCamera.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Take a picture')),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controllerCamera);
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    value: null,
                    color: PaletteOne.secondaryAccent,
                  ),
                );
              }
            },
          ),
          Align(
            child: Container(
              color: Colors.white.withOpacity(0.2),
              width: MediaQuery.of(context).size.width * 5/6,
              height: MediaQuery.of(context).size.height * 2/3,
            ),
          ),
          Positioned(
            height: 80,
            width: 80,
            bottom: 40,
            child: MaterialButton(
              elevation: 10,
              color: PaletteOne.secondaryAccent,
              shape: const CircleBorder(),
              onPressed: () async {
                try {
                  await _initializeControllerFuture;
                  if (!mounted) return;
                  await _controllerCamera.setFlashMode(FlashMode.off);
                  await _controllerCamera.setFocusMode(FocusMode.auto);
                  XFile xFile = await _controllerCamera.takePicture();
                  Uint8List bytes = await xFile.readAsBytes();
                  Future.delayed(const Duration(milliseconds: 100), () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ScannedRoute(
                          imageBytes: bytes,
                          camera: widget.camera,
                          imagePath: xFile.path,
                          cameraController: _controllerCamera,
                        ),
                      ),
                    );
                  },);
                } catch (e) {
                  print(e);
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            child: IconButton(
              icon: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('TAP TO\nGO BACK', style: TextStyle(fontSize: 16, color: PaletteOne.primaryColor), textAlign: TextAlign.center,),
                  Icon(Icons.arrow_downward, color: PaletteOne.primaryColor, size: 25),
                ],
              ),
              onPressed: () {
                Navigator.pop(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => HomeRoute(camera: widget.camera),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    )
                );
              },
            ),
          ),
          const Positioned(
            bottom: 155,
            child: Text('SCAN YOUR SCHEDULE NOTES', style: TextStyle(fontSize: 16, color: PaletteOne.primaryColor), textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }
}