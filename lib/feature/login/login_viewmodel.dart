import 'package:easier_dodam/local/storage_manager.dart';
import 'package:easier_dodam/remote/core/base_response.dart';
import 'package:easier_dodam/remote/login/login_data_source.dart';
import 'package:easier_dodam/remote/login/response/login_response.dart';
import 'package:flutter/material.dart';

class LoginViewmodel with ChangeNotifier {
  late LoginDataSource _loginDataSource;

  String _testState = "";
  String get testState => _testState;

  LoginViewmodel() {
    _loginDataSource = LoginDataSource();
  }

  Future<bool> login(
    String id,
    String pw,
  ) async {
    print(await StorageManager.getUserAccount());
    final BaseResponse<LoginResponse> response =
        await _loginDataSource.login(id, pw);
    await StorageManager.saveUserAccount(id: id, pw: pw);
    await StorageManager.saveUserToken(
      response.data.accessToken,
      response.data.refreshToken,
    );
    _testState =
        "발급된 계정 토큰\naccessToken: ${response.data.accessToken}\nrefreshToken: ${response.data.refreshToken}";
    notifyListeners();
    return true;
  }
}
