// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:crud/models/employee.dart';
import 'package:http/http.dart' as http;

class ServiceApi {
  Future create_employee(
      {required String name,
      required String desId,
      required String depId,
      required String dob}) async {
    final response = await http.post(
        Uri.parse(
            "http://phpstack-598410-2859373.cloudwaysapps.com/api/employees"),
        body: {
          "name": name,
          "designation_Id": desId,
          "department_Id": depId,
          "Date_Of_Birth": dob
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Successfully Added new Employee');
    } else {
      log('Failed to Add Employee Data. ');
      log(response.statusCode.toString());
      return null;
    }
  }

  Future<List<Employee>?> get_employee() async {
    final response = await http.get(Uri.parse(
        "http://phpstack-598410-2859373.cloudwaysapps.com/api/employees"));
    final data = jsonDecode(response.body) as List;
    if (response.statusCode == 200) {
      var users = data.map((e) => Employee.fromJson(e)).toList();
      log("Successfully fetched employee list");
      return users;
    } else {
      log("fail to fetch employee data");
    }
    return null;
  }

  Future delete_employee({
    required String id,
  }) async {
    final response = await http.delete(Uri.parse(
        "http://phpstack-598410-2859373.cloudwaysapps.com/api/employees/$id"));
    if (response.statusCode == 204) {
      log("employee data deleted successfully");
    } else {
      log("failed to delete employee data");
      log(response.statusCode.toString());
    }
    return null;
  }
}
