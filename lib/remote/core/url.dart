import 'package:flutter_config/flutter_config.dart';

abstract class EasierDodamUrl {
  EasierDodamUrl._() {}
  static get _SERVER_URL => FlutterConfig.get('SERVER_URL');

  static get AUTH_LOGIN => _SERVER_URL + "/auth/login";
  static get REISSUE_LOGIN => _SERVER_URL + "/auth/reissue";

  static get OUT_GOING => _SERVER_URL + "/out-going";
  static get OUT_GOING_MY => _SERVER_URL + "/out-going/my";

  static get NIGHT_STUDY => _SERVER_URL + "/night-study";
  static get NIGHT_STUDY_MY => _SERVER_URL + "/night-study/my";
}
