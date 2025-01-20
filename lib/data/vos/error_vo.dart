import 'package:json_annotation/json_annotation.dart';

part 'error_vo.g.dart';

@JsonSerializable()
class ErrorVO {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "error")
  final dynamic error;

  ErrorVO({this.status, this.message,this.error});

  factory ErrorVO.fromJson(Map<String, dynamic> json) =>
      _$ErrorVOFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorVOToJson(this);
 
}
