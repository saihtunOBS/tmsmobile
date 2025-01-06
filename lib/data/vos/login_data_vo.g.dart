// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDataVO _$LoginDataVOFromJson(Map<String, dynamic> json) => LoginDataVO(
      id: json['_id'] as String?,
      email: json['email'] as String?,
      phoneNo: json['phone_number'] as String?,
      photo: json['photo'] as String?,
      businessUnit: json['business_unit'] as String?,
      token: json['token'] as String?,
      verify: (json['verify'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LoginDataVOToJson(LoginDataVO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'photo': instance.photo,
      'email': instance.email,
      'phone_number': instance.phoneNo,
      'verify': instance.verify,
      'business_unit': instance.businessUnit,
      'token': instance.token,
    };
