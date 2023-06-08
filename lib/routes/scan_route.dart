import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../assets/palette/palette.dart';
import '../components/widgets/home_appbar.dart';

class ScanRoute extends StatefulWidget {
  final List<CameraDescription> cameras;
  const ScanRoute({
    super.key,
    required this.cameras
  });

  @override
  State<ScanRoute> createState() => _ScanRouteState();
}

class _ScanRouteState extends State<ScanRoute> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late CameraController cameraController;

  void _initializeCameraController(CameraDescription description) {
    cameraController = CameraController(description, ResolutionPreset.max);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeCameraController(widget.cameras[0]);
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      key: _key,
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: PaletteOne.secondaryColor,
      appBar: HomeAppBar().build(_key, context,
        child: const SizedBox(
          width: double.infinity,
          child: Center(
              child: Text('test')
          ),
        ),
        background: Colors.transparent,
      ) as PreferredSizeWidget,
      body: Stack(
        clipBehavior: Clip.antiAlias,
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          CameraPreview(cameraController),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.green,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(8),
                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return PaletteOne.secondaryAccent;
                          } else if (states.contains(MaterialState.hovered)) {
                            return PaletteOne.secondaryAccent.withOpacity(0.6);
                          } else {
                            return PaletteOne.secondaryAccent;
                          }
                        }),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
