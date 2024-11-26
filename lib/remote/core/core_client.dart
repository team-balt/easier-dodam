import 'dart:convert';

import 'package:easier_dodam/local/storage_manager.dart';
import 'package:easier_dodam/remote/core/request/token_request.dart';
import 'package:easier_dodam/remote/core/response/token_response.dart';
import 'package:easier_dodam/remote/core/url.dart';
import 'package:easier_dodam/remote/login/login_data_source.dart';
import 'package:http/http.dart' as http;

import 'base_response.dart';

class CoreClient {
  static Future<BaseResponse<T>> post<T>({
    required String url,
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? decoder,
    T Function(List<dynamic>)? listDecoder,
    bool sendToken = true,
  }) async {
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    if (sendToken) {
      headers["Authorization"] =
          "Bearer ${(await StorageManager.getUserToken()).accessToken ?? ""}";
    }

    var response = await http.post(
      Uri.parse(url),
      body: json.encode(body),
      headers: headers,
    );
    final responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 401 && sendToken) {
      final accessToken = await _refresh();
      headers["Authorization"] = "Bearer $accessToken";
      response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      print(response.body);
    }

    final Map<String, dynamic> decodeJson =
        jsonDecode(utf8.decode(response.bodyBytes));

    return BaseResponse.fromJsons(
      decodeJson,
      decoder,
      fromJsonList: listDecoder,
    );
  }

  static Future<BaseResponse<T>> get<T>({
    required String url,
    T Function(Map<String, dynamic>)? decoder,
    T Function(List<dynamic>)? listDecoder,
    bool sendToken = true,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (sendToken) {
      headers["Authorization"] =
          "Bearer ${(await StorageManager.getUserToken()).accessToken ?? ""}";
    }

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    final responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);

    if (response.statusCode == 401 && sendToken) {
      final accessToken = await _refresh();
      headers["Authorization"] = "Bearer $accessToken";
      response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      print(response.body);
    }

    final Map<String, dynamic> decodeJson =
        jsonDecode(utf8.decode(response.bodyBytes));

    return BaseResponse.fromJsons(
      decodeJson,
      decoder,
      fromJsonList: listDecoder,
    );
  }

  static Future<BaseResponse<T>> delete<T>({
    required String url,
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? decoder,
    T Function(List<dynamic>)? listDecoder,
    bool sendToken = true,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (sendToken) {
      headers["Authorization"] =
          "Bearer ${(await StorageManager.getUserToken()).accessToken ?? ""}";
    }

    var response = await http.delete(
      Uri.parse(url),
      body: json.encode(body),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 401 && sendToken) {
      final accessToken = await _refresh();
      headers["Authorization"] = "Bearer $accessToken";
      response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      print(response.body);
    }

    final Map<String, dynamic> decodeJson =
        jsonDecode(utf8.decode(response.bodyBytes));

    return BaseResponse.fromJsons(
      decodeJson,
      decoder,
      fromJsonList: listDecoder,
    );
  }

  static bool _isRefresh = false;

  static Future<String> _refresh() async {
    // Token Refresh Once.
    if (_isRefresh) {
      while (_isRefresh) {
        // print("wait");
        await Future.delayed(const Duration(microseconds: 700));
      }
      final tokenDto = await StorageManager.getUserToken();
      if (tokenDto.accessToken == null) {
        throw Exception("Failed Token Refresh");
      }
      return tokenDto.accessToken!;
    }

    _isRefresh = true;
    final tokenDto = await StorageManager.getUserToken();
    if (tokenDto.refreshToken == null) {
      _isRefresh = false;
      throw Exception("Not Find Refresh Token");
    }

    final headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse(EasierDodamUrl.REISSUE_LOGIN),
      body: json.encode(TokenRequest(tokenDto.refreshToken!)),
      headers: headers,
    );
    print(response.body);

    if (response.statusCode == 401 || response.statusCode == 403) {
      final userDto = await StorageManager.getUserAccount();
      if (userDto.id == null || userDto.pw == null) {
        throw Exception("Not Found Account");
      }
      final loginResponse = await LoginDataSource().login(
        userDto.id!,
        userDto.pw!,
      );

      await StorageManager.saveUserToken(
        loginResponse.data.accessToken,
        loginResponse.data.refreshToken,
      );
      _isRefresh = false;
      return loginResponse.data.accessToken;
    }

    final Map<String, dynamic> decodeJson =
        jsonDecode(utf8.decode(response.bodyBytes));
    final baseResponse =
        BaseResponse.fromJsons(decodeJson, TokenResponse.fromJson);
    await StorageManager.saveUserAccessToken(baseResponse.data.accessToken);
    _isRefresh = false;
    return baseResponse.data.accessToken;
  }

  Future<bool> hasToken() async {
    final tokenDto = await StorageManager.getUserToken();
    return tokenDto.accessToken != null && tokenDto.accessToken!.isNotEmpty;
  }
}
