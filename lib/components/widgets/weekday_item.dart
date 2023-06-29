import 'package:flutter/material.dart';

class WeekDayItem extends StatefulWidget {
  const WeekDayItem({super.key});

  @override
  State<WeekDayItem> createState() => _WeekDayItemState();
}

class _WeekDayItemState extends State<WeekDayItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.green,
      child: GestureDetector(),
    );
  }
}
