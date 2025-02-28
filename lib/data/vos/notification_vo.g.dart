// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationVO _$NotificationVOFromJson(Map<String, dynamic> json) =>
    NotificationVO(
      id: json['_id'] as String?,
      referenceId: json['reference_id'] as String?,
      status: (json['status'] as num?)?.toInt(),
      referenceType: json['reference_type'] as String?,
      tenant: json['tenant'] == null
          ? null
          : TenantVO.fromJson(json['tenant'] as Map<String, dynamic>),
      businessUnit: json['business_unit'] == null
          ? null
          : BusinessUnitVO.fromJson(
              json['business_unit'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      referenceData: json['reference_data'] == null
          ? null
          : ReferenceDataVO.fromJson(
              json['reference_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationVOToJson(NotificationVO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'reference_id': instance.referenceId,
      'status': instance.status,
      'reference_type': instance.referenceType,
      'tenant': instance.tenant,
      'business_unit': instance.businessUnit,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'reference_data': instance.referenceData,
    };

TenantVO _$TenantVOFromJson(Map<String, dynamic> json) => TenantVO(
      id: json['_id'] as String?,
      tenantName: json['tenant_name'] as String?,
      photo: json['photo'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
      fcmToken: json['fcm_token'] as String?,
    );

Map<String, dynamic> _$TenantVOToJson(TenantVO instance) => <String, dynamic>{
      '_id': instance.id,
      'tenant_name': instance.tenantName,
      'photo': instance.photo,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
      'fcm_token': instance.fcmToken,
    };

BusinessUnitVO _$BusinessUnitVOFromJson(Map<String, dynamic> json) =>
    BusinessUnitVO(
      id: json['_id'] as String?,
      buName: json['bu_name'] as String?,
    );

Map<String, dynamic> _$BusinessUnitVOToJson(BusinessUnitVO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'bu_name': instance.buName,
    };

ReferenceDataVO _$ReferenceDataVOFromJson(Map<String, dynamic> json) =>
    ReferenceDataVO(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      complaints: json['complaint'] as String?,
      description: json['description'] as String?,
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ReferenceDataVOToJson(ReferenceDataVO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'complaint': instance.complaints,
      'title': instance.title,
      'description': instance.description,
      'photos': instance.photos,
    };
