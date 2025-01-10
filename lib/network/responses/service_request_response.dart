import 'package:json_annotation/json_annotation.dart';
import 'package:tmsmobile/data/vos/service_request_vo.dart';

part 'service_request_response.g.dart';

@JsonSerializable()
class ServiceRequestResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<ServiceRequestVo>? data;

  @JsonKey(name: 'paginator')
  final PaginatorVo? paginator;

  ServiceRequestResponse({
    this.status,
    this.message,
    this.data,
    this.paginator,
  });

  factory ServiceRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceRequestResponseToJson(this);
}

@JsonSerializable()
class PaginatorVo {
  @JsonKey(name: "totalItems")
  final int? totalItems;

  @JsonKey(name: "totalPages")
  final int? totalPages;

  @JsonKey(name: "itemFrom")
  final int? itemFrom;

  @JsonKey(name: "itemTo")
  final int? itemTo;

  @JsonKey(name: "currentPage")
  final int? currentPage;

  final int? limit;

  @JsonKey(name: "nextPage")
  final int? nextPage;

  @JsonKey(name: "previousPage")
  final int? previousPage;

  PaginatorVo({
    this.totalItems,
    this.totalPages,
    this.itemFrom,
    this.itemTo,
    this.currentPage,
    this.limit,
    this.nextPage,
    this.previousPage,
  });

  factory PaginatorVo.fromJson(Map<String, dynamic> json) =>
      _$PaginatorVoFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatorVoToJson(this);
}
