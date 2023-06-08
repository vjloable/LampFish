import 'package:flutter/material.dart';

import '../../assets/palette/palette.dart';

class DeadlineCard extends StatefulWidget {
  final double height;
  final String itemA;
  final String itemB;
  final String itemC;
  final TextStyle? textStyle;
  const DeadlineCard({
    required this.height,
    required this.itemA,
    required this.itemB,
    required this.itemC,
    this.textStyle,
    super.key,
  });

  @override
  State<DeadlineCard> createState() => _DeadlineCardState();
}

class _DeadlineCardState extends State<DeadlineCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * (9/11),
      height: widget.height,
      child: Column(
        children: [
          SizedBox(
            height: widget.height * (8/15),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: PaletteOne.secondaryAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(widget.itemA, style: widget.textStyle),
                      )
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: widget.height * (4/15),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: PaletteOne.secondaryAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(widget.itemB, style: widget.textStyle),
                      )
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: widget.height * (3/15),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: PaletteOne.secondaryAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(widget.itemC, style: widget.textStyle),
                      )
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
