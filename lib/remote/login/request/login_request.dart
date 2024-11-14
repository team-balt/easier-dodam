import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  String id;
  String pw;
  String? pushToken;

  LoginRequest({required this.id, required this.pw, this.pushToken});

  Map<String, dynamic> toJson() {
    return _$LoginRequestToJson(this);
  }
}
