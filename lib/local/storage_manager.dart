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

  static Future<void> saveUserAccessToken(String accessToken) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
  }

  static Future<String?> getUserAccessToken(String accessToken) async {
    return await _storage.read(key: _accessTokenKey);
  }

  static get _idKey => "id";
  static get _pwKey => "pw";
  static get _accessTokenKey => "accessToken";
}
