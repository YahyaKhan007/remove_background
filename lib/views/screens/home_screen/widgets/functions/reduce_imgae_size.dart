import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

Future<Uint8List> compressFile(File file) async {
  var result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    minWidth: 2300,
    minHeight: 1500,
    quality: 50,
    rotate: 90,
  );
  log(file.lengthSync().toString());
  return result!;
}

Future<File> uint8ListToFile(Uint8List uint8List) async {
  Directory tempDir = Directory.systemTemp;
  String tempFileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
  File tempFile = File('${tempDir.path}/$tempFileName');
  await tempFile.writeAsBytes(uint8List);
  return tempFile;
}
