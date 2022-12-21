// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);

import 'dart:convert';

Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

String employeeToJson(Employee data) => json.encode(data.toJson());

class Employee {
  Employee({
    required this.id,
    required this.geoLocation,
    required this.image,
    required this.name,
    required this.dateOfBirth,
    required this.designationId,
    required this.departmentId,
  });

  final int id;
  final String geoLocation;
  final String image;
  final String name;
  final DateTime dateOfBirth;
  final int designationId;
  final int departmentId;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        geoLocation: json["geo_location"],
        image: json["image"],
        name: json["name"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        designationId: json["designation_id"],
        departmentId: json["department_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "geo_location": geoLocation,
        "image": image,
        "name": name,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "designation_id": designationId,
        "department_id": departmentId,
      };
}
