class NRCData {
  final String id;
  final String nameEn;
  final String nameMm;
  String nrcCode;
  final String createdAt;
  final String updatedAt;

  NRCData({
    required this.id,
    required this.nameEn,
    required this.nameMm,
    required this.nrcCode,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create an object from JSON
  factory NRCData.fromJson(Map<String, dynamic> json) {
    return NRCData(
      id: json['id'],
      nameEn: json['name_en'],
      nameMm: json['name_mm'],
      nrcCode: json['nrc_code'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_mm': nameMm,
      'nrc_code': nrcCode,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class NRCResponse {
  final List<NRCData> data;

  NRCResponse({required this.data});

  // Factory constructor to parse the entire JSON response
  factory NRCResponse.fromJson(Map<String, dynamic> json) {
    return NRCResponse(
      data: (json['data'] as List)
          .map((item) => NRCData.fromJson(item))
          .toList(),
    );
  }

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
