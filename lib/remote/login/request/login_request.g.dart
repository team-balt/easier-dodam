// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      id: json['id'] as String,
      pw: json['pw'] as String,
      pushToken: json['pushToken'] as String?,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pw': instance.pw,
      'pushToken': instance.pushToken,
    };
