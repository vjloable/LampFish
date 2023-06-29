// ignore_for_file: unnecessary_cast
import 'package:flutter/material.dart';

import '../../assets/palette/palette.dart';

class HomeAppBar {
  Widget? build(GlobalKey<ScaffoldState> key, BuildContext context, {Widget? child, Color? background}) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        scrolledUnderElevation: 10,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        backgroundColor: background ?? Colors.transparent,
        title: child,
      ),
    );
  }
}
