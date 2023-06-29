import 'package:flutter/material.dart';

import '../../assets/palette/palette.dart';

class IconNavButton extends StatelessWidget {
  final double height;
  final double width;
  final IconData? icon;
  final Text? text;
  final double? iconSize;
  final Color? iconColor;
  final double? fontSize;
  final bool isSelected;
  final void Function()? onPressed;
  const IconNavButton({
    Key? key,
    required this.icon,
    this.text,
    this.fontSize,
    this.iconSize,
    this.iconColor,
    this.onPressed,
    this.height = 70,
    this.width = 70,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      enableFeedback: true,
      splashColor: PaletteOne.primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(50),
      child: Ink(
        width: 50,
        height: 50,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: iconColor),
            // SizedBox(child: Text(text?.data as String, style: TextStyle(color: PaletteOne.primaryColor, fontWeight: FontWeight.bold, fontSize: 12)))
          ],
        ),
      ),
    );
  }
}
