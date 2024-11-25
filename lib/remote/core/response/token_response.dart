import 'package:json_annotation/json_annotation.dart';

part "token_response.g.dart";

@JsonSerializable()
class TokenResponse {
  String accessToken;

  TokenResponse(this.accessToken);

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);
}
