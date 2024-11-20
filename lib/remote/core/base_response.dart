import 'package:json_annotation/json_annotation.dart';

class BaseResponse<T> {
  String message;
  int status;
  T data;

  BaseResponse(
      {required this.message, required this.status, required this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json, BaseObject target) {
    return BaseResponse(
      status: json['status'],
      message: json['message'],
      data: target.fromJson(json['data']),
    );
  }

  factory BaseResponse.fromJsons(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? fromJson, {
    T Function(List<dynamic>)? fromJsonList,
  }) {
    final data = json['data'];
    if (data is List) {
      // 배열 처리
      if (fromJsonList == null) {
        throw ArgumentError(
            'fromJsonList function must be provided to parse data into type List<dynamic> cast to T.');
      }
      return BaseResponse(
          status: json['status'],
          message: json['message'],
          data: fromJsonList(json['data']));
    } else {
      if (data is! T && fromJson == null) {
        throw ArgumentError(
            'fromJson function must be provided to parse data into type T.');
      }
      // 단일 객체 처리
      return BaseResponse(
        status: json['status'],
        message: json['message'],
        data: data is T ? data : fromJson!(json['data']),
      );
    }
  }
}

abstract class BaseObject<T> {
  T fromJson(json);
}
