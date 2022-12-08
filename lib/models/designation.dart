// To parse this JSON data, do
//
//     final designation = designationFromJson(jsonString);

import 'dart:convert';

List<Designation> designationFromJson(String str) => List<Designation>.from(
    json.decode(str).map((x) => Designation.fromJson(x)));

String designationToJson(List<Designation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Designation {
  Designation({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final DateTime createdAt;
  final dynamic updatedAt;

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
      };
}
