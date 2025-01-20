import 'package:json_annotation/json_annotation.dart';

part 'otp_response.g.dart';

@JsonSerializable()
class OTPResponse {
  final String? token;
  final String? message;

  OTPResponse({
    this.token,
    this.message,
  });

  factory OTPResponse.fromJson(Map<String, dynamic> json) =>
      _$OTPResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OTPResponseToJson(this);
}


