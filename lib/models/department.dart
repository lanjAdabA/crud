// To parse this JSON data, do
//
//     final department = departmentFromJson(jsonString);

import 'dart:convert';

List<Department> departmentFromJson(String str) =>
    List<Department>.from(json.decode(str).map((x) => Department.fromJson(x)));

String departmentToJson(List<Department> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Department {
  Department({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final DateTime createdAt;
  final dynamic updatedAt;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
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
