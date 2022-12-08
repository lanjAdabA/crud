// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);

import 'dart:convert';

List<Employee> employeeFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {
  Employee({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.designationId,
    required this.departmentId,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final DateTime dateOfBirth;
  final int designationId;
  final int departmentId;
  final dynamic remark;
  final DateTime createdAt;
  final DateTime? updatedAt;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        designationId: json["designation_id"],
        departmentId: json["department_id"],
        remark: json["remark"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "designation_id": designationId,
        "department_id": departmentId,
        "remark": remark,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
