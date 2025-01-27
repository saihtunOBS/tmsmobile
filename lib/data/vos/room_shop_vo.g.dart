// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_shop_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomShopVO _$RoomShopVOFromJson(Map<String, dynamic> json) => RoomShopVO(
      branch: json['branch'] as String?,
      building: json['building'] as String?,
      floor: json['floor'] as String?,
      zone: json['zone'] as String?,
      shop: json['shop'] == null
          ? null
          : ShopVO.fromJson(json['shop'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoomShopVOToJson(RoomShopVO instance) =>
    <String, dynamic>{
      'branch': instance.branch,
      'building': instance.building,
      'floor': instance.floor,
      'zone': instance.zone,
      'shop': instance.shop,
    };

ShopVO _$ShopVOFromJson(Map<String, dynamic> json) => ShopVO(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      status: (json['status'] as num?)?.toInt(),
      propertyType: (json['property_type'] as num?)?.toInt(),
      totalArea: (json['total_area'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      floor: json['floor'] as String?,
      building: json['building'] as String?,
      branch: json['branch'] as String?,
      zone: json['zone'] as String?,
      roomType: json['room_type'] as String?,
      parkingInformation: json['parking_information'] as List<dynamic>?,
      businessUnit: json['business_unit'] as String?,
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ShopVOToJson(ShopVO instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'property_type': instance.propertyType,
      'total_area': instance.totalArea,
      'price': instance.price,
      'floor': instance.floor,
      'building': instance.building,
      'branch': instance.branch,
      'zone': instance.zone,
      'room_type': instance.roomType,
      'parking_information': instance.parkingInformation,
      'business_unit': instance.businessUnit,
      '__v': instance.version,
    };
