import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@injectable
class RequestHandler {
  static const baseUrl = 'https://cerebrumscanner.com:44157';

  static const timeout = Duration(seconds: 5);

  static const headers = {'Content-Type': 'application/json'};

  final HttpClient _client = HttpClient();

  RequestHandler() {
    _client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  }

  Future<String> get(String path) => IOClient(_client)
      .get(Uri.parse('$baseUrl/$path'), headers: headers)
      .timeout(timeout)
      .then((response) {
        if (response.statusCode == 200) {
          return response.body;
        }
        throw Exception(response.body);
      });

  Future<String> post(String path, Map<String, String> data) =>
      IOClient(_client)
          .post(Uri.parse('$baseUrl/$path'), body: jsonEncode(data))
          .timeout(timeout)
          .then((response) {
            if (response.statusCode == 200) {
              return response.body;
            }

            throw Exception(response.body);
          });

  Future<String> generateImage(String label, String description) {
    final requestUuid = Uuid();
    final path =
        "/var/www/cerebrumscanner.com/data/uploads/dreamer/DreamLabel/${requestUuid.toString()}";
    final body = {
      "workflow": "DreamLabel",
      "description": description,
      "label": label,
      "negativePrompt": "blur",
      "cfgValue": "4",
      "labelFontSize": "150",
      "textMarginX": "0",
      "textMarginY": "100",
      "nsfwThresholdValue": "0.95",
      "promptStyle": "base",
      "uid": requestUuid.toString(),
      "outputComfyPath": path,
    };
    return post('test/server', body).then((response) {
      if (jsonDecode(response)['outputComfyPath'] == path) {
        return Future.delayed(
          Duration(seconds: 10),
          () =>
              'https://cerebrumscanner.com/data/uploads/dreamer/DreamLabel/${requestUuid.toString()}/output_image.png',
        );
      }
      throw Exception('An error occurred!');
    });
  }
}
