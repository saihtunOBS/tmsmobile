import 'package:json_annotation/json_annotation.dart';

part 'parking_vo.g.dart';

@JsonSerializable()
class ParkingVO {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "parking_floor")
  final ParkingDetail? parkingFloor;

  @JsonKey(name: "parking_zone")
  final ParkingDetail? parkingZone;

  @JsonKey(name: "parking_code")
  final ParkingCode? parkingCode;

  ParkingVO({
    this.id,
    this.parkingFloor,
    this.parkingZone,
    this.parkingCode,
  });

  factory ParkingVO.fromJson(Map<String, dynamic> json) =>
      _$ParkingVOFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingVOToJson(this);
}

@JsonSerializable()
class ParkingDetail {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "name")
  final String? name;

  ParkingDetail({this.id, this.name});

  factory ParkingDetail.fromJson(Map<String, dynamic> json) =>
      _$ParkingDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingDetailToJson(this);
}

@JsonSerializable()
class ParkingCode {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "parking_code")
  final String? parkingCode;

  ParkingCode({this.id, this.parkingCode});

  factory ParkingCode.fromJson(Map<String, dynamic> json) =>
      _$ParkingCodeFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingCodeToJson(this);
}
