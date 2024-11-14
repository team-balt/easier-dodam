import 'dart:io';

import 'package:easier_dodam/remote/core/base_response.dart';
import 'package:easier_dodam/remote/login/login_data_source.dart';
import 'package:easier_dodam/remote/login/response/login_response.dart';
import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  late LoginDataSource _loginDataSource;

  String _testState = "";
  String get testState => _testState;

  LoginViewModel() {
    _loginDataSource = LoginDataSource();
  }

  Future<void> login(
    String id,
    String pw,
  ) async {
    final BaseResponse<LoginResponse> response =
        await _loginDataSource.login(id, pw);
    _testState =
        "발급된 계정 토큰\naccessToken: ${response.data.accessToken}\nrefreshToken: ${response.data.refreshToken}";
    notifyListeners();
  }
}
