import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileHandler {
  void write(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/datastore.txt');
    await file.writeAsString(text);
  }

  Future<String> read() async {
    String text = "";
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/datastore.txt');
      text = await file.readAsString();
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }
}