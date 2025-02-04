// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_process_data_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceProcessDataVO _$MaintenanceProcessDataVOFromJson(
        Map<String, dynamic> json) =>
    MaintenanceProcessDataVO(
      pending: json['pending'] == null
          ? null
          : PendingVO.fromJson(json['pending'] as Map<String, dynamic>),
      survey: json['survey'] == null
          ? null
          : SurveyVO.fromJson(json['survey'] as Map<String, dynamic>),
      quotation: json['quotation'] == null
          ? null
          : QuotationVO.fromJson(json['quotation'] as Map<String, dynamic>),
      acceptReject: json['acceptReject'] == null
          ? null
          : AcceptRejectVO.fromJson(
              json['acceptReject'] as Map<String, dynamic>),
      processing: json['processing'] == null
          ? null
          : ProcessingVO.fromJson(json['processing'] as Map<String, dynamic>),
      finished: json['finished'] == null
          ? null
          : FinishedVO.fromJson(json['finished'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MaintenanceProcessDataVOToJson(
        MaintenanceProcessDataVO instance) =>
    <String, dynamic>{
      'pending': instance.pending,
      'survey': instance.survey,
      'quotation': instance.quotation,
      'acceptReject': instance.acceptReject,
      'processing': instance.processing,
      'finished': instance.finished,
    };
