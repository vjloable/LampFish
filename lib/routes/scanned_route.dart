import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:lampfish/assets/palette/palette.dart';
import 'package:lampfish/routes/save_task_route.dart';

class ScannedRoute extends StatefulWidget {
  final Uint8List imageBytes;
  final String imagePath;
  final CameraDescription camera;
  final CameraController cameraController;
  const ScannedRoute({
    super.key,
    required this.imageBytes,
    required this.imagePath,
    required this.camera,
    required this.cameraController,
  });

  @override
  State<ScannedRoute> createState() => _ScannedRouteState();
}

class _ScannedRouteState extends State<ScannedRoute> {
  late InputImage inputImage;
  late Future<RecognizedText> futureRecognizedText;

  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  List<String> selectedTasks = [];

  @override
  void initState() {
    super.initState();
    // inputImage = _initInputImage(widget.cameraImage, widget.cameraDescription);
    inputImage = _initInputImage(widget.imagePath);
    processText(inputImage);
  }

  void processText(InputImage inputImage) async {
    futureRecognizedText = textRecognizer.processImage(inputImage);
  }

  InputImage _initInputImage(String filepath) {
    // final rotation = InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    // final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // final plane = imageBytes.planes.first;
    // return InputImage.fromBytes(
    //   bytes: plane.bytes,
    //   metadata: InputImageMetadata(
    //     size: Size(image.width.toDouble(), image.height.toDouble()),
    //     rotation: rotation!, // used only in Android
    //     format: format!, // used only in iOS
    //     bytesPerRow: plane.bytesPerRow, // used only in iOS
    //   ),
    // );
    return InputImage.fromFilePath(filepath);
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
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              child: Image.file(
                File(widget.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          FutureBuilder(
            future: futureRecognizedText,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                RecognizedText recognizedText = snapshot.data!;
                Map<String,bool> tasks = {};
                for (TextBlock block in recognizedText.blocks) {
                  for (TextLine line in block.lines) {
                    tasks[line.text] = false;
                  }
                }
                if (tasks.keys.isEmpty) {
                  return Positioned(
                    bottom: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0).subtract(const EdgeInsets.only(bottom: 0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Icon(Icons.warning_amber, color: Colors.amber, size: 50,),
                                  SizedBox(height: 10),
                                  Text(
                                    'No task detected',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    'Unable to read text from the image. Make sure there is sufficient light or focus before taking another picture.\n\nPress the "BACK" button to proceed.',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w200,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 50,
                              child: MaterialButton(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                elevation: 7,
                                color: PaletteOne.primaryColor.shade900,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const SizedBox(
                                  height: 45,
                                  child: Center(
                                    child: Text(
                                      'BACK',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Positioned(
                    bottom: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0).subtract(const EdgeInsets.only(bottom: 0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text(
                                    'DETECTED ${tasks.length} TASK${tasks.length > 1 ? 'S' : ''}!',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Select tasks to include',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Text(
                                    'NOTE: You can still edit task details after the selection',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(selectedTasks.length < tasks.keys.length ? 'SELECT ALL ${selectedTasks.isNotEmpty ? '(${selectedTasks.length})' : ''}' : 'UNSELECT ALL (${selectedTasks.length})'),
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        if (selectedTasks.length < tasks.keys.length) {
                                          setState(() {
                                            selectedTasks = tasks.keys.toList();
                                          });
                                        } else {
                                          setState(() {
                                            selectedTasks.clear();
                                          });
                                        }
                                      },
                                      icon: selectedTasks.length < tasks.keys.length
                                          ? const Icon(Icons.done_all)
                                          : const Icon(Icons.remove_done_outlined),
                                    ),
                                    //
                                    // child: MaterialButton(
                                    //   shape: const CircleBorder(),
                                    //
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       selectedTasks = tasks.keys.toList();
                                    //     });
                                    //   },
                                    //   child: const Icon(Icons.select_all),
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: PaletteOne.primaryColor.shade600,
                                    borderRadius: const BorderRadius.all(Radius.circular(5))
                                ),
                                child: MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: Scrollbar(
                                    thumbVisibility: true,
                                    thickness: 7,
                                    child: ListView.builder(
                                      itemCount: tasks.keys.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              if (selectedTasks.contains(tasks.keys.elementAt(index))) {
                                                setState(() {
                                                  selectedTasks.remove(tasks.keys.elementAt(index));
                                                });
                                              } else {
                                                setState(() {
                                                  selectedTasks.add(tasks.keys.elementAt(index));
                                                });
                                              }
                                            },
                                            child: Container(
                                              color: selectedTasks.contains(tasks.keys.elementAt(index))
                                                  ? PaletteOne.primaryAccent.shade300
                                                  : PaletteOne.secondaryColor.shade100,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(width: 10),
                                                    Text('${index+1}'),
                                                    const SizedBox(width: 20),
                                                    Expanded(
                                                      child: Text(
                                                        tasks.keys.elementAt(index),
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w900,
                                                          color: PaletteOne.secondaryColor.shade900,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 14),
                                                    Icon(
                                                      Icons.done,
                                                      size: 24,
                                                      color: selectedTasks.contains(tasks.keys.elementAt(index))
                                                          ? PaletteOne.secondaryColor.shade900
                                                          : Colors.transparent,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: MaterialButton(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                      ),
                                      elevation: 7,
                                      color: PaletteOne.primaryColor.shade900,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const SizedBox(
                                        height: 45,
                                        child: Center(
                                          child: Text(
                                            'BACK',
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: MaterialButton(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                      ),
                                      disabledColor: PaletteOne.primaryAccent.shade100,
                                      elevation: 7,
                                      color: PaletteOne.primaryAccent,
                                      onPressed: selectedTasks.isNotEmpty
                                          ?
                                      () async {
                                        // FileHandler fileHandler = FileHandler();
                                        // var stringTasks = await fileHandler.read();
                                        // var tempA = stringTasks.split(" | ");
                                        // var tempB = [];
                                        // tempB = (List.from(tempA)..addAll(selectedTasks)).toSet().toList();
                                        // fileHandler.write(tempB.join(" | "));
                                        // stringTasks = await fileHandler.read();
                                        Future.delayed(const Duration(milliseconds: 100), () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) => SaveTaskRoute(
                                                listUnformattedTasks: selectedTasks,
                                              ))
                                          );
                                        });
                                      }
                                          :
                                      null,
                                      child: const SizedBox(
                                        height: 45,
                                        child: Center(
                                          child: Text(
                                            'DONE',
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              } else {
                return Positioned(
                  bottom: 0,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CircularProgressIndicator(
                        value: null,
                        color: PaletteOne.secondaryAccent,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      )
    );
  }
}
