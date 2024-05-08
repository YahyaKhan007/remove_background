import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RemoveBgApiService {
  var url = Uri.parse('https://ai-remove-image-background.p.rapidapi.com/');

  Future<Uint8List?> removeBackground(String image) async {
    log("came to remove bg function");
    var headers = {
      // usama_acount   :    00e08c981dmsh69c9205fae3e2a4p1f0496jsn530555aef1a1
      // yahya_account     :    ec6af885d0mshd4c8f11160308a9p1b76b3jsn5cb08f582ff0
      'X-RapidAPI-Key': '00e08c981dmsh69c9205fae3e2a4p1f0496jsn530555aef1a1',
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
