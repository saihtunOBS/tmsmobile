import 'package:json_annotation/json_annotation.dart';

part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  @JsonKey(name: "numberOfShops")
  final int? numberOfShops;

  @JsonKey(name: "tenantName")
  final String? tenantName;

  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "nrc")
  final String? nrc;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "phone_number")
  final String? phoneNumber;

  @JsonKey(name: "status")
  final int? status;

  @JsonKey(name: "city")
  final CityVO? city;

  @JsonKey(name: "township")
  final TownshipVO? township;

  @JsonKey(name: "address")
  final String? address;

  @JsonKey(name: 'photo')
  final String? photo;

  @JsonKey(name: "created_date")
  final DateTime? createdDate;

  UserVO({
    this.numberOfShops,
    this.tenantName,
    this.id,
    this.nrc,
    this.email,
    this.phoneNumber,
    this.status,
    this.city,
    this.township,
    this.address,
    this.createdDate,
    this.photo
  });

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}

@JsonSerializable()
class CityVO {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "city_name")
  final String? cityName;

  @JsonKey(name: "__v")
  final int? version;

  CityVO({
    this.id,
    this.cityName,
    this.version,
  });

  factory CityVO.fromJson(Map<String, dynamic> json) => _$CityVOFromJson(json);

  Map<String, dynamic> toJson() => _$CityVOToJson(this);
}

@JsonSerializable()
class TownshipVO {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "city_id")
  final String? cityId;

  @JsonKey(name: "township_name")
  final String? townshipName;

  @JsonKey(name: "__v")
  final int? version;

  TownshipVO({
    this.id,
    this.cityId,
    this.townshipName,
    this.version,
  });

  factory TownshipVO.fromJson(Map<String, dynamic> json) =>
      _$TownshipVOFromJson(json);

  Map<String, dynamic> toJson() => _$TownshipVOToJson(this);
}
