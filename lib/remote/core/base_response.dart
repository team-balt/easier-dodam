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
    T Function(Map<String, dynamic>)? fromJson,
  ) {
    final data = json['data'];
    if (data is! T && fromJson == null) {
      throw ArgumentError(
          'fromJson function must be provided to parse data into type T.');
    }

    return BaseResponse(
      status: json['status'],
      message: json['message'],
      data: data is T ? data : fromJson!(json['data']), // T 타입으로 변환
    );
  }
}

abstract class BaseObject<T> {
  T fromJson(json);
}
