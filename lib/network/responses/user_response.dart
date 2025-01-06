import 'package:json_annotation/json_annotation.dart';
import 'package:tmsmobile/data/vos/user_vo.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final UserVO? data;

  UserResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
