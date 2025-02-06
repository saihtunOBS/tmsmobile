import 'package:json_annotation/json_annotation.dart';

import 'invoice_setting_vo.dart';
import 'quotation_detail_vo.dart';
part 'quotation_vo.g.dart';

@JsonSerializable()
class QuotationVO {
  final int? status;
  final String? shop;
  final String? issue;
  final String? tenant;
  final List<String>? attach;
  final String? description;
  @JsonKey(name: 'quotation_date')
  final String? date;
  final List<QuotationDetailVO>? details;
  @JsonKey(name: "invoice_setting")
  final InvoiceSettingVO? invoiceSetting;
  @JsonKey(name: "sub_total")
  final int? subTotal;
  @JsonKey(name: "grand_total")
  final int? grandTotal;
  

  QuotationVO(
      {this.status,
      this.shop,
      this.date,
      this.issue,
      this.tenant,
      this.attach,
      this.description,
      this.details,
      this.invoiceSetting,
      this.subTotal,
      this.grandTotal});

  factory QuotationVO.fromJson(Map<String, dynamic> json) =>
      _$QuotationVOFromJson(json);

  Map<String, dynamic> toJson() => _$QuotationVOToJson(this);
}
