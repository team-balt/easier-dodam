import 'package:json_annotation/json_annotation.dart';

part "token_request.g.dart";

@JsonSerializable()
class TokenRequest {
  String refreshToken;

  TokenRequest(this.refreshToken);

  Map<String, dynamic> toJson() => _$TokenRequestToJson(this);
}
