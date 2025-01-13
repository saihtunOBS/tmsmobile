// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_information_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractInformationResponse _$ContractInformationResponseFromJson(
        Map<String, dynamic> json) =>
    ContractInformationResponse(
      status: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ContractInformationVO.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContractInformationResponseToJson(
        ContractInformationResponse instance) =>
    <String, dynamic>{
      'success': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
