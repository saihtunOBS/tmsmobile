import 'package:json_annotation/json_annotation.dart';

part 'error_data_vo.g.dart';

@JsonSerializable()
class ErrorDataVO {
  @JsonKey(name: 'password')
  final String? password;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'phone')
  final String? phone;

  ErrorDataVO({this.password, this.type,this.phone});

  factory ErrorDataVO.fromJson(Map<String, dynamic> json) =>
      _$ErrorDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDataVOToJson(this);
}