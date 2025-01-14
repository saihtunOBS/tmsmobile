// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingVO _$ParkingVOFromJson(Map<String, dynamic> json) => ParkingVO(
      id: json['_id'] as String?,
      parkingFloor: json['parking_floor'] == null
          ? null
          : ParkingDetail.fromJson(
              json['parking_floor'] as Map<String, dynamic>),
      parkingZone: json['parking_zone'] == null
          ? null
          : ParkingDetail.fromJson(
              json['parking_zone'] as Map<String, dynamic>),
      parkingCode: json['parking_code'] == null
          ? null
          : ParkingCode.fromJson(json['parking_code'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ParkingVOToJson(ParkingVO instance) => <String, dynamic>{
      '_id': instance.id,
      'parking_floor': instance.parkingFloor,
      'parking_zone': instance.parkingZone,
      'parking_code': instance.parkingCode,
    };

ParkingDetail _$ParkingDetailFromJson(Map<String, dynamic> json) =>
    ParkingDetail(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ParkingDetailToJson(ParkingDetail instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };

ParkingCode _$ParkingCodeFromJson(Map<String, dynamic> json) => ParkingCode(
      id: json['_id'] as String?,
      parkingCode: json['parking_code'] as String?,
    );

Map<String, dynamic> _$ParkingCodeToJson(ParkingCode instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'parking_code': instance.parkingCode,
    };
