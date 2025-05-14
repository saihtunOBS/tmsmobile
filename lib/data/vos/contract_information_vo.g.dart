// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_information_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractInformationVO _$ContractInformationVOFromJson(
        Map<String, dynamic> json) =>
    ContractInformationVO(
      id: json['_id'] as String?,
      tenant: json['tenant'] == null
          ? null
          : ContractTenant.fromJson(json['tenant'] as Map<String, dynamic>),
      propertyType: json['property_type'] as String?,
      propertyInformation: (json['property_information'] as List<dynamic>?)
          ?.map((e) => PropertyInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      contractData: json['contract_information'] == null
          ? null
          : ContractInformationData.fromJson(
              json['contract_information'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContractInformationVOToJson(
        ContractInformationVO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'tenant': instance.tenant,
      'property_type': instance.propertyType,
      'property_information': instance.propertyInformation,
      'contract_information': instance.contractData,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

ContractTenant _$ContractTenantFromJson(Map<String, dynamic> json) =>
    ContractTenant(
      id: json['_id'] as String?,
      tenantName: json['tenant_name'] as String?,
      tenantCategory: json['tenant_category'] == null
          ? null
          : TenantCategory.fromJson(
              json['tenant_category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContractTenantToJson(ContractTenant instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'tenant_name': instance.tenantName,
      'tenant_category': instance.tenantCategory,
    };

TenantCategory _$TenantCategoryFromJson(Map<String, dynamic> json) =>
    TenantCategory(
      id: json['_id'] as String?,
      tenantCategoryName: json['tenant_category_name'] as String?,
    );

Map<String, dynamic> _$TenantCategoryToJson(TenantCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'tenant_category_name': instance.tenantCategoryName,
    };

PropertyInformation _$PropertyInformationFromJson(Map<String, dynamic> json) =>
    PropertyInformation(
      id: json['_id'] as String?,
      branch: json['branch'] == null
          ? null
          : PropertyDetail.fromJson(json['branch'] as Map<String, dynamic>),
      building: json['building'] == null
          ? null
          : PropertyDetail.fromJson(json['building'] as Map<String, dynamic>),
      floor: json['floor'] == null
          ? null
          : PropertyDetail.fromJson(json['floor'] as Map<String, dynamic>),
      zone: json['zone'] == null
          ? null
          : PropertyDetail.fromJson(json['zone'] as Map<String, dynamic>),
      shop: json['shop'] == null
          ? null
          : ContractShop.fromJson(json['shop'] as Map<String, dynamic>),
      roomType: json['room_type'] == null
          ? null
          : RoomType.fromJson(json['room_type'] as Map<String, dynamic>),
      totalArea: json['total_area'] as String?,
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PropertyInformationToJson(
        PropertyInformation instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'branch': instance.branch,
      'building': instance.building,
      'floor': instance.floor,
      'zone': instance.zone,
      'shop': instance.shop,
      'room_type': instance.roomType,
      'total_area': instance.totalArea,
      'price': instance.price,
    };

PropertyDetail _$PropertyDetailFromJson(Map<String, dynamic> json) =>
    PropertyDetail(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PropertyDetailToJson(PropertyDetail instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };

ContractShop _$ContractShopFromJson(Map<String, dynamic> json) => ContractShop(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      status: (json['status'] as num?)?.toInt(),
      totalArea: (json['total_area'] as num?)?.toInt(),
      parkingData: (json['parking_information'] as List<dynamic>?)
          ?.map((e) => ParkingVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContractShopToJson(ContractShop instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'total_area': instance.totalArea,
      'parking_information': instance.parkingData,
    };

RoomType _$RoomTypeFromJson(Map<String, dynamic> json) => RoomType(
      id: json['_id'] as String?,
      roomType: json['room_type'] as String?,
    );

Map<String, dynamic> _$RoomTypeToJson(RoomType instance) => <String, dynamic>{
      '_id': instance.id,
      'room_type': instance.roomType,
    };

ContractInformationData _$ContractInformationDataFromJson(
        Map<String, dynamic> json) =>
    ContractInformationData(
      contractName: json['contract_name'] as String?,
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      duration: json['contract_duration'] as String?,
      terminateDate: json['terminate_date'],
      terminateStatus: json['terminate_status'],
    );

Map<String, dynamic> _$ContractInformationDataToJson(
        ContractInformationData instance) =>
    <String, dynamic>{
      'contract_name': instance.contractName,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'contract_duration': instance.duration,
      'terminate_date': instance.terminateDate,
      'terminate_status': instance.terminateStatus,
    };
