import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lampfish/routes/scan_route.dart';

import '../assets/palette/palette.dart';
import '../components/widgets/deadline_card.dart';
import '../components/widgets/home_appbar.dart';
import '../components/widgets/icon_nav_button.dart';

class HomeRoute extends StatefulWidget {
  final List<CameraDescription> cameras;
  const HomeRoute({
    super.key,
    required this.cameras
  });

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: PaletteOne.primaryColor,
      appBar: HomeAppBar().build(_key, context,
          child: const SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('User'),
            ),
          )
      ) as PreferredSizeWidget,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Text('DEADLINES', style: TextStyle(fontSize: 20, color: PaletteOne.secondaryColor, fontWeight: FontWeight.bold)),
                    DeadlineCard(
                      height: 170,
                      itemA: 'Lecture A',
                      itemB: 'Lecture B',
                      itemC: 'Lecture C',
                      textStyle: TextStyle(fontSize: 40, color: PaletteOne.primaryColor),
                    ),
                  ],
                ),
              )
          ),
          Positioned(
            bottom: 50,
            child: Material(
              elevation: 20,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: PaletteOne.secondaryColor,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * (8/13),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconNavButton(
                      icon: Icons.home_outlined,
                      text: const Text('HOME'),
                      onPressed: () {},
                    ),
                    IconNavButton(
                      icon: Icons.document_scanner_outlined,
                      text: const Text('SCAN'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => ScanRoute(cameras: widget.cameras),
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
                    IconNavButton(
                      icon: Icons.view_timeline_outlined,
                      text: const Text('TIMETABLE'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
