import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalFileProvider {
  final String _filePath = 'CheckMe_Pro.txt';

  Future<void> writeToFile(String matriculeToWrite) async {
    final directory = await getApplicationDocumentsDirectory();

    try {
      final file = File('${directory.path}/$_filePath');
      //create the file
      await file.create();
      // Write to the file
      await file.writeAsString(matriculeToWrite);
    } catch (error) {
      rethrow;
    }
  }

  Future<String> readFromFile() async {
    final directory = await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/$_filePath');
    // Read from the file
    try {
      final matriculeRead = await file.readAsString();
      return matriculeRead;
    } catch (e) {
      rethrow;
    }
  }
}
