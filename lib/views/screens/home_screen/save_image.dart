import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

Future<String?> saveImage(Uint8List imageData, String fileName) async {
  try {
    // Get the external storage directory
    Directory? directory = await getExternalStorageDirectory();
    if (directory == null) {
      throw const FileSystemException('External storage directory not found.');
    }

    // Create a new file in the specified directory
    File file = File('${directory.path}/$fileName');

    // Write the image data to the file
    await file.writeAsBytes(imageData);

    log('Image saved to: ${file.path}');

    return file.path;
  } catch (e) {
    log('Error saving image: $e');
    return null;
  }
}

