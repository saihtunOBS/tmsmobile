// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceRequestVo _$ServiceRequestVoFromJson(Map<String, dynamic> json) =>
    ServiceRequestVo(
      id: json['_id'] as String?,
      tenant: json['tenant'] == null
          ? null
          : Tenant.fromJson(json['tenant'] as Map<String, dynamic>),
      shop: json['shop'] == null
          ? null
          : Shop.fromJson(json['shop'] as Map<String, dynamic>),
      status: (json['status'] as num?)?.toInt(),
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      pendingDate: json['pending_date'] as String?,
      surveyDate: json['survey_date'] as String?,
      quotationDate: json['quotation_date'] as String?,
      acceptRejectDate: json['accept_reject_date'] as String?,
      processingDate: json['processing_date'] as String?,
      finishDate: json['finished_date'] as String?,
      businessUnit: json['business_unit'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num?)?.toInt(),
      description: json['description'] as String?,
      issue: json['issue'] == null
          ? null
          : Issue.fromJson(json['issue'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceRequestVoToJson(ServiceRequestVo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'tenant': instance.tenant,
      'shop': instance.shop,
      'status': instance.status,
      'issue': instance.issue,
      'description': instance.description,
      'photos': instance.photos,
      'business_unit': instance.businessUnit,
      'pending_date': instance.pendingDate,
      'finished_date': instance.finishDate,
      'survey_date': instance.surveyDate,
      'quotation_date': instance.quotationDate,
      'accept_reject_date': instance.acceptRejectDate,
      'processing_date': instance.processingDate,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
    };

Tenant _$TenantFromJson(Map<String, dynamic> json) => Tenant(
      id: json['_id'] as String?,
      tenantName: json['tenant_name'] as String?,
    );

Map<String, dynamic> _$TenantToJson(Tenant instance) => <String, dynamic>{
      '_id': instance.id,
      'tenant_name': instance.tenantName,
    };

Shop _$ShopFromJson(Map<String, dynamic> json) => Shop(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };

Issue _$IssueFromJson(Map<String, dynamic> json) => Issue(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };
