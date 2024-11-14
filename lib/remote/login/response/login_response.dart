import 'package:easier_dodam/remote/core/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends BaseObject<LoginResponse> {
  String refreshToken;
  String accessToken;

  LoginResponse({required this.refreshToken, required this.accessToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  @override
  LoginResponse fromJson(json) {
    return LoginResponse.fromJson(json);
  }
}
