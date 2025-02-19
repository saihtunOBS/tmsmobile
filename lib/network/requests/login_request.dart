import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  @JsonKey(name: "phone_number")
  String? phone;

  @JsonKey(name: "password")
  String? password;

  @JsonKey(name: 'fcm_token')
  String? fcmToken;

  LoginRequest(this.phone, this.password,this.fcmToken);

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
