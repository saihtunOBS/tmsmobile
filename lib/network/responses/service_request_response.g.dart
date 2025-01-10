// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceRequestResponse _$ServiceRequestResponseFromJson(
        Map<String, dynamic> json) =>
    ServiceRequestResponse(
      status: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ServiceRequestVo.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginator: json['paginator'] == null
          ? null
          : PaginatorVo.fromJson(json['paginator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceRequestResponseToJson(
        ServiceRequestResponse instance) =>
    <String, dynamic>{
      'success': instance.status,
      'message': instance.message,
      'data': instance.data,
      'paginator': instance.paginator,
    };

PaginatorVo _$PaginatorVoFromJson(Map<String, dynamic> json) => PaginatorVo(
      totalItems: (json['totalItems'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      itemFrom: (json['itemFrom'] as num?)?.toInt(),
      itemTo: (json['itemTo'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      nextPage: (json['nextPage'] as num?)?.toInt(),
      previousPage: (json['previousPage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginatorVoToJson(PaginatorVo instance) =>
    <String, dynamic>{
      'totalItems': instance.totalItems,
      'totalPages': instance.totalPages,
      'itemFrom': instance.itemFrom,
      'itemTo': instance.itemTo,
      'currentPage': instance.currentPage,
      'limit': instance.limit,
      'nextPage': instance.nextPage,
      'previousPage': instance.previousPage,
    };
