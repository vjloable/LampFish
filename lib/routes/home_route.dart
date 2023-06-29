import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lampfish/components/tools/file_handler.dart';
import 'package:lampfish/routes/scan_route.dart';
import 'package:lampfish/routes/task_route.dart';

import '../assets/palette/palette.dart';
import '../components/widgets/deadline_card.dart';
import '../components/widgets/home_appbar.dart';
import '../components/widgets/icon_nav_button.dart';

class HomeRoute extends StatefulWidget {
  final CameraDescription camera;
  const HomeRoute({
    super.key,
    required this.camera,
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
        background: PaletteOne.primaryColor.shade100,
        child: const SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.account_circle_outlined, color: PaletteOne.secondaryColor,),
                SizedBox(width: 10,),
                Text('User', style: TextStyle(color: PaletteOne.secondaryColor, fontSize: 24)),
              ],
            ),
          ),
        ),
      ) as PreferredSizeWidget,
      body: Container(
        decoration: BoxDecoration(
          // color: Color(0xFFFAC3C3)
          color: PaletteOne.primaryColor.shade100,
        ),
        child: Stack(
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
                      const SizedBox(height: 20),
                      Container(
                        height: MediaQuery.of(context).size.width * 1/8,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 1/8,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Sun', style: TextStyle(fontSize: 16),),
                                  Text('25', style: TextStyle(fontSize: 24),),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 1/8,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Mon', style: TextStyle(fontSize: 16),),
                                  Text('26', style: TextStyle(fontSize: 24),),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 1/8,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Tue', style: TextStyle(fontSize: 16),),
                                  Text('27', style: TextStyle(fontSize: 24),),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(50)),
                                color: Colors.red.withOpacity(0.2),
                              ),
                              width: MediaQuery.of(context).size.width * 1/8,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('TODAY', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),),
                                  Text('28', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 1/8,
                              child: const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Thu', style: TextStyle(fontSize: 16),),
                                    Text('29', style: TextStyle(fontSize: 24),),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 1/8,
                              child: const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Fri', style: TextStyle(fontSize: 16),),
                                    Text('30', style: TextStyle(fontSize: 24),),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 1/8,
                              child: const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Sat', style: TextStyle(fontSize: 16),),
                                    Text('1', style: TextStyle(fontSize: 24),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * (7/11),
                        height: MediaQuery.of(context).size.width * (7/11),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(500)),
                                  color: PaletteOne.secondaryAccent.shade100,
                                ),
                                width: MediaQuery.of(context).size.width * (7/11),
                                height: MediaQuery.of(context).size.width * (7/11),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(200)),
                                  color: PaletteOne.secondaryAccent,
                                ),
                                width: MediaQuery.of(context).size.width * (7/11) * 0.65,
                                height: MediaQuery.of(context).size.width * (7/11) * 0.65,
                              ),
                              const Text(
                                '65 %',
                                style: TextStyle(
                                  color: PaletteOne.primaryColor,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w900,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Column(
                              children: [
                                Text(
                                  'Your work is almost done!',
                                  style: TextStyle(
                                    color: PaletteOne.secondaryColor.shade700,
                                    fontSize: 45,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Prioritize your upcoming latest deadline',
                                  style: TextStyle(
                                    color: PaletteOne.secondaryColor.shade600,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Material(
                        elevation: 7,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                          child: DeadlineCard(
                            height: 240,
                            header: Text(
                              'TO-DO',
                              style: TextStyle(
                                fontSize: 30,
                                color: PaletteOne.secondaryColor,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                              ),
                            ),
                            itemA: ['Lecture A', '11:20 AM'],
                            itemB: ['Lecture B', '01:30 PM'],
                            itemC: ['Lecture C', '06:30 PM'],
                            textStyleHead: TextStyle(fontSize: 26, color: PaletteOne.primaryColor, fontWeight: FontWeight.w900),
                            textStyleBody: TextStyle(fontSize: 40, color: PaletteOne.primaryColor, fontWeight: FontWeight.w100),
                          ),
                        ),
                      ),
                      const SizedBox(height: 150),
                    ],
                  ),
                )
            ),
            Positioned(
              bottom: 40,
              child: Material(
                elevation: 20,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: PaletteOne.primaryColor.shade100,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * (8/13),
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconNavButton(
                        icon: Icons.home,
                        text: const Text('HOME'),
                        iconColor: PaletteOne.secondaryColor.shade900,
                        onPressed: () {},
                      ),
                      IconNavButton(
                        icon: Icons.document_scanner_outlined,
                        text: const Text('SCAN'),
                        iconColor: PaletteOne.secondaryColor.shade900,
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => ScanRoute(camera: widget.camera),
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
                        iconColor: PaletteOne.secondaryColor.shade900,
                        onPressed: () async {
                          FileHandler fileHandler = FileHandler();
                          var stringTasks = await fileHandler.read();
                          Future.delayed(const Duration(milliseconds: 100), () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => TaskRoute(camera: widget.camera),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
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
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
