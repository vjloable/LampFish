import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../assets/palette/palette.dart';

class DeadlineCard extends StatefulWidget {
  final double height;
  final List<String> itemA;
  final List<String> itemB;
  final List<String> itemC;
  final Widget? header;
  final TextStyle? textStyleHead;
  final TextStyle? textStyleBody;
  const DeadlineCard({
    required this.height,
    required this.itemA,
    required this.itemB,
    required this.itemC,
    this.textStyleHead,
    this.textStyleBody,
    this.header,
    super.key,
  });

  @override
  State<DeadlineCard> createState() => _DeadlineCardState();
}

class _DeadlineCardState extends State<DeadlineCard> {

  @override
  Widget build(BuildContext context) {
    double headerHeight = 30;
    return SizedBox(
      width: MediaQuery.of(context).size.width * (8/11),
      height: widget.height + headerHeight + 20 + 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              height: 30,
              width: double.infinity,
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: widget.header,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Material(
              elevation: 5,
              color: PaletteOne.secondaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.7,
                height: widget.height * (30/50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.itemA[1], style: TextStyle(fontSize: widget.textStyleHead!.fontSize, color: PaletteOne.primaryColor, fontWeight: widget.textStyleHead!.fontWeight)),
                            Text(widget.itemA[0], style: TextStyle(fontSize: widget.textStyleBody!.fontSize, color: PaletteOne.primaryColor, fontWeight: widget.textStyleBody!.fontWeight)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Material(
              elevation: 5,
              color: PaletteOne.secondaryColor.shade400,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: SizedBox(
                height: widget.height * (10/50),
                width: MediaQuery.sizeOf(context).width * 0.65,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30.0),
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(widget.itemB[1], style: widget.textStyleHead),
                            const VerticalDivider(),
                            Text(widget.itemB[0], style: widget.textStyleBody),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Material(
              elevation: 5,
              color: PaletteOne.secondaryColor.shade300,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: SizedBox(
                height: widget.height * (10/50),
                width: MediaQuery.sizeOf(context).width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30.0),
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(widget.itemC[1], style: widget.textStyleHead),
                            const VerticalDivider(),
                            Text(widget.itemC[0], style: widget.textStyleBody),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

          ],
        ),
      ),
    );
  }
}
