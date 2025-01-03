// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserVo {
  int id;
  String name;
  UserVo({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory UserVo.fromMap(Map<String, dynamic> map) {
    return UserVo(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserVo.fromJson(String source) =>
      UserVo.fromMap(json.decode(source) as Map<String, dynamic>);
}
