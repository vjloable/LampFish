import 'package:calendar_view/calendar_view.dart' as cv;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lampfish/assets/palette/palette.dart';
import 'package:lampfish/components/widgets/icon_nav_button.dart';
import 'package:lampfish/routes/home_route.dart';
import 'package:lampfish/routes/scan_route.dart';
import 'package:table_calendar/table_calendar.dart' as tc;

class TaskRoute extends StatefulWidget {
  final CameraDescription camera;
  const TaskRoute({
    super.key,
    required this.camera,
  });

  @override
  State<TaskRoute> createState() => _TaskRouteState();
}

class _TaskRouteState extends State<TaskRoute> {
  final keyDayView = GlobalKey<cv.DayViewState>();
  final keyTableCalendar = GlobalKey();
  tc.CalendarFormat _calendarFormat = tc.CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  cv.EventController eventController = cv.EventController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width,
              color: PaletteOne.secondaryColor.shade900,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10).add(const EdgeInsets.only(top: 55, bottom: 40)),
                child: tc.TableCalendar(
                  key: keyTableCalendar,
                  pageAnimationEnabled: true,
                  pageJumpingEnabled: true,
                  headerStyle: tc.HeaderStyle(
                    rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.white),
                    leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                      color: PaletteOne.primaryColor.shade300,
                      fontWeight: FontWeight.w900,
                      fontSize: 26,
                    ),
                    titleCentered: true,
                    headerMargin: EdgeInsets.zero,
                    headerPadding: EdgeInsets.zero
                  ),
                  daysOfWeekHeight: 30,
                  daysOfWeekStyle: tc.DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      color: PaletteOne.primaryColor.shade300,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                    weekendStyle: TextStyle(
                      color: PaletteOne.primaryColor.shade300,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    )
                  ),
                  rowHeight: 40,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                  calendarFormat: _calendarFormat,
                  calendarStyle: tc.CalendarStyle(
                    defaultTextStyle: TextStyle(
                      color: PaletteOne.primaryColor.shade300,
                    ),
                    weekendTextStyle: TextStyle(
                      color: PaletteOne.primaryColor.shade300,
                    )
                  ),
                  selectedDayPredicate: (day) {
                    // Use `selectedDayPredicate` to determine which day is currently selected.
                    // If this returns true, then `day` will be marked as selected.

                    // Using `isSameDay` is recommended to disregard
                    // the time-part of compared DateTime objects.
                    return tc.isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!tc.isSameDay(_selectedDay, selectedDay)) {
                      // Call `setState()` when updating the selected day
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        keyDayView.currentState?.animateToDate(selectedDay);
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                    _focusedDay = focusedDay;
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: cv.DayView(
                  key: keyDayView,
                  dayTitleBuilder: (date) {
                    return Center(
                      child: Text(
                        DateFormat('dd\nEEEE').format(date).toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                    );
                  },
                  headerStyle: const cv.HeaderStyle(
                    rightIconVisible: false,
                    leftIconVisible: false,
                  ),
                  pageTransitionCurve: Curves.bounceInOut,

                  initialDay: _focusedDay,
                  controller: eventController,
                  onDateTap: (date) {
                    setState(() {
                      _selectedDay = date;
                    });
                  },
                ),
              ),
            ),
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
                      onPressed: () {
                        Navigator.pop(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => HomeRoute(camera: widget.camera),
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
                      },
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
