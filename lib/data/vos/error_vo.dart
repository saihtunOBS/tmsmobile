import 'package:json_annotation/json_annotation.dart';

import 'error_data_vo.dart';

part 'error_vo.g.dart';

@JsonSerializable()
class ErrorVO {
  @JsonKey(name: "status_code")
  final int? statusCode;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "errors")
  final ErrorDataVO? data;

  ErrorVO({this.statusCode, this.message,this.data});

  factory ErrorVO.fromJson(Map<String, dynamic> json) =>
      _$ErrorVOFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorVOToJson(this);

  String? getErrorMessages() {
    if (data == null) return message ?? "";

    List<String> errors = [];

    if (data?.password != null) {
      errors.add(data!.password!);
    }
    if (data?.type != null) {
      errors.add(data!.type!);
    }
    if (data?.phone != null) {
      errors.add(data!.phone!);
    }

    return errors.isNotEmpty ? errors.join('\n') : message;
  }
}
