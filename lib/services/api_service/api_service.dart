import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RemoveBgApiService {
  var url = Uri.parse('https://ai-remove-image-background.p.rapidapi.com/');

  Future<Uint8List?> removeBackground(String image) async {


    // await dotenv.load(fileName: 'assets/.env');


    int fileSizeInBytes = await File(image).length();

    // Convert bytes to kilobytes
    double fileSizeInKB = fileSizeInBytes / 1024;

    // Print the file size in kilobytes
    log('Sent picture for bg remove size is : $fileSizeInKB KB');

    log("came to remove bg function");
    var headers = {
      // usama_acount   :    00e08c981dmsh69c9205fae3e2a4p1f0496jsn530555aef1a1
      // yahya_account     :    ec6af885d0mshd4c8f11160308a9p1b76b3jsn5cb08f582ff0

      // hafsa account     :    3f80f3bb90mshf07d28116d52aa6p1ee4c2jsne00bc354e825

      'X-RapidAPI-Key': '3f80f3bb90mshf07d28116d52aa6p1ee4c2jsne00bc354e825',
      'X-Rapidapi-Host': 'ai-remove-image-background.p.rapidapi.com'
    };

    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', image));

    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    log("removed bg: ${response.statusCode}");

    if (response.statusCode == 200) {
      log('200');

      // print(await response.stream.bytesToString());
      print(response.bodyBytes);
      return response.bodyBytes;
    } else {
      log('Error');
      print(response.reasonPhrase);

      return null;
    }
  }
}
