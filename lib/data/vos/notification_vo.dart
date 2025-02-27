import 'package:json_annotation/json_annotation.dart';
part 'notification_vo.g.dart';

@JsonSerializable()
class NotificationVO {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "reference_id")
  final String? referenceId;

  @JsonKey(name: "status")
  final int? status;

  @JsonKey(name: "reference_type")
  final String? referenceType;

  @JsonKey(name: "tenant")
  final TenantVO? tenant;

  @JsonKey(name: "business_unit")
  final BusinessUnitVO? businessUnit;

  @JsonKey(name: "createdAt")
  final DateTime? createdAt;

  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;

  @JsonKey(name: "reference_data")
  final ReferenceDataVO? referenceData;

  NotificationVO({
    this.id,
    this.referenceId,
    this.status,
    this.referenceType,
    this.tenant,
    this.businessUnit,
    this.createdAt,
    this.updatedAt,
    this.referenceData,
  });

  factory NotificationVO.fromJson(Map<String, dynamic> json) => _$NotificationVOFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationVOToJson(this);
}

@JsonSerializable()
class TenantVO {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "tenant_name")
  final String? tenantName;

  @JsonKey(name: "photo")
  final String? photo;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "phone_number")
  final String? phoneNumber;

  @JsonKey(name: "address")
  final String? address;

  @JsonKey(name: "fcm_token")
  final String? fcmToken;

  TenantVO({
    this.id,
    this.tenantName,
    this.photo,
    this.email,
    this.phoneNumber,
    this.address,
    this.fcmToken,
  });

  factory TenantVO.fromJson(Map<String, dynamic> json) => _$TenantVOFromJson(json);

  Map<String, dynamic> toJson() => _$TenantVOToJson(this);
}

@JsonSerializable()
class BusinessUnitVO {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "bu_name")
  final String? buName;

  BusinessUnitVO({this.id, this.buName});

  factory BusinessUnitVO.fromJson(Map<String, dynamic> json) => _$BusinessUnitVOFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessUnitVOToJson(this);
}

@JsonSerializable()
class ReferenceDataVO {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "photos")
  final List<String>? photos;

  ReferenceDataVO({this.id, this.title, this.description, this.photos});

  factory ReferenceDataVO.fromJson(Map<String, dynamic> json) => _$ReferenceDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$ReferenceDataVOToJson(this);
}
