// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      numberOfShops: (json['numberOfShops'] as num?)?.toInt(),
      tenantName: json['tenantName'] as String?,
      id: json['_id'] as String?,
      nrc: json['nrc'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      status: (json['status'] as num?)?.toInt(),
      city: json['city'] == null
          ? null
          : CityVO.fromJson(json['city'] as Map<String, dynamic>),
      township: json['township'] == null
          ? null
          : TownshipVO.fromJson(json['township'] as Map<String, dynamic>),
      address: json['address'] as String?,
      createdDate: json['created_date'] == null
          ? null
          : DateTime.parse(json['created_date'] as String),
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'numberOfShops': instance.numberOfShops,
      'tenantName': instance.tenantName,
      '_id': instance.id,
      'nrc': instance.nrc,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'status': instance.status,
      'city': instance.city,
      'township': instance.township,
      'address': instance.address,
      'photo': instance.photo,
      'created_date': instance.createdDate?.toIso8601String(),
    };

CityVO _$CityVOFromJson(Map<String, dynamic> json) => CityVO(
      id: json['_id'] as String?,
      cityName: json['city_name'] as String?,
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CityVOToJson(CityVO instance) => <String, dynamic>{
      '_id': instance.id,
      'city_name': instance.cityName,
      '__v': instance.version,
    };

TownshipVO _$TownshipVOFromJson(Map<String, dynamic> json) => TownshipVO(
      id: json['_id'] as String?,
      cityId: json['city_id'] as String?,
      townshipName: json['township_name'] as String?,
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TownshipVOToJson(TownshipVO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'city_id': instance.cityId,
      'township_name': instance.townshipName,
      '__v': instance.version,
    };
