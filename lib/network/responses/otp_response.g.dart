// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPResponse _$OTPResponseFromJson(Map<String, dynamic> json) => OTPResponse(
      token: json['token'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$OTPResponseToJson(OTPResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'message': instance.message,
    };
