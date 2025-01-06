import 'package:json_annotation/json_annotation.dart';

part 'login_data_vo.g.dart';

@JsonSerializable()
class LoginDataVO {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "photo")
  final String? photo;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "phone_number")
  final String? phoneNo;

  @JsonKey(name: "verify")
  final int? verify;

  @JsonKey(name: 'business_unit')
  final String? businessUnit;

  @JsonKey(name: 'token')
  final String? token;

  LoginDataVO(
      {this.id,
        this.email,
        this.phoneNo,
        this.photo,
        this.businessUnit,
        this.token,
        this.verify});

  factory LoginDataVO.fromJson(Map<String, dynamic> json) =>
      _$LoginDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataVOToJson(this);
}
