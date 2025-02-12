import 'package:json_annotation/json_annotation.dart';

import 'accept_reject_vo.dart';
import 'finish_vo.dart';
import 'pending_vo.dart';
import 'processing_vo.dart';
import 'quotation_vo.dart';
import 'survey_vo.dart';

part 'maintenance_process_data_vo.g.dart';

@JsonSerializable()
class MaintenanceProcessDataVO {
  @JsonKey(name: "pending")
  final PendingVO? pending;
  @JsonKey(name: "survey")
  final SurveyVO? survey;
  @JsonKey(name: "quotation")
  final QuotationVO? quotation;
  @JsonKey(name: "accept_reject")
  final AcceptRejectVO? acceptReject;
  @JsonKey(name: "processing")
  final ProcessingVO? processing;
  @JsonKey(name: "finished")
  final FinishedVO? finished;

  MaintenanceProcessDataVO(
      {this.pending,
      this.survey,
      this.quotation,
      this.acceptReject,
      this.processing,
      this.finished});

  factory MaintenanceProcessDataVO.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceProcessDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceProcessDataVOToJson(this);
}