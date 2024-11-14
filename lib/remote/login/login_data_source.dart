import 'dart:convert';

import 'package:easier_dodam/remote/core/base_response.dart';
import 'package:easier_dodam/remote/core/core_client.dart';
import 'package:easier_dodam/remote/core/url.dart';
import 'package:easier_dodam/remote/login/request/login_request.dart';
import 'package:easier_dodam/remote/login/response/login_response.dart';
import 'package:http/http.dart' as http;

class LoginDataSource {
  Future<BaseResponse<LoginResponse>> login(String id, String pw) async {
    return await CoreClient.post(
      url: EasierDodamUrl.AUTH_LOGIN,
      body: LoginRequest(id: id, pw: pw).toJson(),
      decoder: LoginResponse.fromJson,
    );
  }
}
