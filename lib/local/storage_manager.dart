import 'package:easier_dodam/local/dto/token_dto.dart';
import 'package:easier_dodam/local/dto/user_account_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageManager {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveUserAccount({
    required String id,
    required String pw,
  }) async {
    await _storage.write(key: _idKey, value: id);
    await _storage.write(key: _pwKey, value: pw);
  }

  static Future<void> deleteUserAccount() async {
    await _storage.deleteAll();
  }

  static Future<UserAccountDto> getUserAccount() async {
    return UserAccountDto(
      id: await _storage.read(key: _idKey),
      pw: await _storage.read(key: _pwKey),
    );
  }

  static Future<void> saveUserToken(
    String accessToken,
    String refreshToken,
  ) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  static Future<void> saveUserAccessToken(String accessToken) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
  }

  static Future<TokenDto> getUserToken() async {
    return TokenDto(
      accessToken: await _storage.read(key: _accessTokenKey),
      refreshToken: await _storage.read(key: _refreshTokenKey),
    );
  }

  static get _idKey => "id";
  static get _pwKey => "pw";
  static get _accessTokenKey => "accessToken";
  static get _refreshTokenKey => "refreshToken";
}
