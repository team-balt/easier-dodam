import 'dart:convert';

import 'package:http/http.dart' as http;

import 'base_response.dart';

class CoreClient {
  static Future<BaseResponse<T>> post<T>({
    required String url,
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? decoder,
  }) async {
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(body),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(response.body);

    final Map<String, dynamic> decodeJson = jsonDecode(response.body);

    return BaseResponse.fromJsons(decodeJson, decoder);
  }
}
