/// The `Apiclient` class is responsible for making HTTP GET requests to a specified path with optional
/// parameters and handling the response accordingly.
import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_app/data/core/api_constants.dart';

class Apiclient {
  final Client _client;

  Apiclient(this._client);

  dynamic get(String path, {Map<dynamic, dynamic>? params}) async {
    final response = await _client.get(
        // getPath(path,params: params),
        Uri.parse(getPath(path, params: params)),
        headers: {
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  String getPath(String path, {Map<dynamic, dynamic>? params}) {
    var paramString = '';
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {
        paramString += '&$key=$value';
      });
    }

    return '${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}$paramString';
  }
}
