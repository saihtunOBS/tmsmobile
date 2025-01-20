import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_request.g.dart';

@JsonSerializable()
class VerifyOtpRequest {
  @JsonKey(name: "code")
  String? code;

  VerifyOtpRequest(this.code);

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);
}
