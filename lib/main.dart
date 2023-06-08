import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lampfish/routes/home_route.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();

  runApp(MyApp(cameras: _cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MyApp({
    super.key,
    required this.cameras
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFDFDFD),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeRoute(cameras: cameras),
    );
  }
}