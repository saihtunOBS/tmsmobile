import 'package:json_annotation/json_annotation.dart';

import 'process_vo.dart';

part 'service_request_vo.g.dart';

@JsonSerializable()
class ServiceRequestVo {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "tenant")
  final Tenant? tenant;

  @JsonKey(name: "shop")
  final Shop? shop;

  @JsonKey(name: 'status')
  final int? status;

   @JsonKey(name: "issue")
  final Issue? issue;

  @JsonKey(name: "process")
  final List<ProcessVO>? processData;

   @JsonKey(name: "description")
  final String? description;

  final List<String>? photos;

  @JsonKey(name: "business_unit")
  final String? businessUnit;

  @JsonKey(name: "pending_date")
  final String? pendingDate;

  @JsonKey(name: "finished_date")
  final dynamic finishDate;

  @JsonKey(name: "approve_date")
  final DateTime? approveDate;

  @JsonKey(name: "survey_date")
  final dynamic surveyDate;

  @JsonKey(name: "quotation_date")
  final String? quotationDate;

  @JsonKey(name: "accept_reject_date")
  final String? acceptRejectDate;

  @JsonKey(name: "processing_date")
  final String? processingDate;

  @JsonKey(name: "createdAt")
  final DateTime? createdAt;

  @JsonKey(name: 'extension_date')
  final dynamic extensionDate;

  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;

  @JsonKey(name: "amount")
  final dynamic amount;

  @JsonKey(name: "deposit_amount")
  final dynamic depositAmount;

  @JsonKey(name: "__v")
  final int? version;

  ServiceRequestVo({
    this.id,
    this.tenant,
    this.shop,
    this.status,
    this.photos,
    this.extensionDate,
    this.pendingDate,
    this.approveDate,
    this.processData,
    this.surveyDate,
    this.quotationDate,
    this.acceptRejectDate,
    this.processingDate,
    this.amount,
    this.depositAmount,
    this.finishDate,
    this.businessUnit,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.description,
    this.issue
  });

  factory ServiceRequestVo.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestVoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceRequestVoToJson(this);
}

@JsonSerializable()
class Tenant {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "tenant_name")
  final String? tenantName;

  Tenant({this.id, this.tenantName});

  factory Tenant.fromJson(Map<String, dynamic> json) => _$TenantFromJson(json);

  Map<String, dynamic> toJson() => _$TenantToJson(this);
}

@JsonSerializable()
class Shop {
  @JsonKey(name: "_id")
  final String? id;

  final String? name;

  Shop({this.id, this.name});

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);

  Map<String, dynamic> toJson() => _$ShopToJson(this);
}

@JsonSerializable()
class Issue {
  @JsonKey(name: "_id")
  final String? id;

  final String? name;

  Issue({this.id, this.name});

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);

  Map<String, dynamic> toJson() => _$IssueToJson(this);
}
