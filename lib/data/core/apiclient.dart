import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_app/data/core/api_constants.dart';

class Apiclient {
  final Client _client;

  Apiclient(this._client);

  dynamic get(String path) async {
    final response = await _client.get(
        Uri.parse(
            '${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}'),
        headers: {
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
