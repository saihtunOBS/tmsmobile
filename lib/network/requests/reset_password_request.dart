import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  @JsonKey(name: "new_password")
  String? newPassword;

  @JsonKey(name: "confirm_password")
  String? confirmPassword;

  ResetPasswordRequest(this.newPassword, this.confirmPassword);

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
