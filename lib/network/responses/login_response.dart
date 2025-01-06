import 'package:json_annotation/json_annotation.dart';

import '../../data/vos/login_data_vo.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final LoginDataVO? data;

  LoginResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
