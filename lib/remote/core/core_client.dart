import 'dart:convert';

import 'package:easier_dodam/local/storage_manager.dart';
import 'package:http/http.dart' as http;

import 'base_response.dart';

class CoreClient {
  static Future<BaseResponse<T>> post<T>({
    required String url,
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? decoder,
    bool sendToken = true,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (sendToken) {
      headers["Authorization"] =
          "Bearer ${await StorageManager.getUserAccessToken() ?? ""}";
    }

    final response = await http.post(
      Uri.parse(url),
      body: json.encode(body),
      headers: headers,
    );

    print(response.body);

    final Map<String, dynamic> decodeJson = jsonDecode(response.body);

    return BaseResponse.fromJsons(decodeJson, decoder);
  }

  static Future<BaseResponse<T>> get<T>({
    required String url,
    T Function(Map<String, dynamic>)? decoder,
    bool sendToken = true,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (sendToken) {
      headers["Authorization"] =
          "Bearer ${await StorageManager.getUserAccessToken() ?? ""}";
    }

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print(response.body);

    final Map<String, dynamic> decodeJson = jsonDecode(response.body);

    return BaseResponse.fromJsons(decodeJson, decoder);
  }
}
