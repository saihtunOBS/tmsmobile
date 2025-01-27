import 'package:json_annotation/json_annotation.dart';

part 'room_shop_vo.g.dart';

@JsonSerializable()
class RoomShopVO {
  final String? branch;
  final String? building;
  final String? floor;
  final String? zone;
  final ShopVO? shop;

  RoomShopVO({
    this.branch,
    this.building,
    this.floor,
    this.zone,
    this.shop,
  });

  factory RoomShopVO.fromJson(Map<String, dynamic> json) =>
      _$RoomShopVOFromJson(json);

  Map<String, dynamic> toJson() => _$RoomShopVOToJson(this);
}

@JsonSerializable()
class ShopVO {
  @JsonKey(name: "_id")
  final String? id;
  final String? name;
  final int? status;
  @JsonKey(name: "property_type")
  final int? propertyType;
  @JsonKey(name: "total_area")
  final int? totalArea;
  final int? price;
  final String? floor;
  final String? building;
  final String? branch;
  final String? zone;
  @JsonKey(name: "room_type")
  final String? roomType;
  @JsonKey(name: "parking_information")
  final List<dynamic>? parkingInformation;
  @JsonKey(name: "business_unit")
  final String? businessUnit;
  @JsonKey(name: "__v")
  final int? version;

  ShopVO({
    this.id,
    this.name,
    this.status,
    this.propertyType,
    this.totalArea,
    this.price,
    this.floor,
    this.building,
    this.branch,
    this.zone,
    this.roomType,
    this.parkingInformation,
    this.businessUnit,
    this.version,
  });

  factory ShopVO.fromJson(Map<String, dynamic> json) => _$ShopVOFromJson(json);

  Map<String, dynamic> toJson() => _$ShopVOToJson(this);
}
