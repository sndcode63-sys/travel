import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileHelper {
  // Get Application Documents Directory
  static Future<String> getAppDocumentsPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Save file in app documents
  static Future<File> saveFile(String fileName, List<int> bytes) async {
    final path = await getAppDocumentsPath();
    final file = File("$path/$fileName");
    return await file.writeAsBytes(bytes);
  }

  // Read file from app documents
  static Future<String?> readFile(String fileName) async {
    try {
      final path = await getAppDocumentsPath();
      final file = File("$path/$fileName");
      return await file.readAsString();
    } catch (e) {
      return null;
    }
  }

  // Delete file
  static Future<bool> deleteFile(String fileName) async {
    try {
      final path = await getAppDocumentsPath();
      final file = File("$path/$fileName");
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
