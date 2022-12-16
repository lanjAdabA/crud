// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:crud/models/department.dart';
import 'package:crud/models/designation.dart';
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
          "designation_id": desId,
          "department_id": depId,
          "date_of_birth": dob
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

  Future update_employee(
      {required String id,
      required String name,
      required String desId,
      required String depId,
      required String dob}) async {
    // final prefs = await SharedPreferences.getInstance();
    log(id);
    final response = await http.patch(
        Uri.parse(
            'http://phpstack-598410-2859373.cloudwaysapps.com/api/employees/$id'),
        body: {
          "name": name,
          "designation_id": desId,
          "department_id": depId,
          "date_of_birth": dob
        });
    // prefs.setInt('emp_updatecode', response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Successfully post Data');
    } else {
      log('Failed to PostData.');
      log(response.statusCode.toString());
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

  Future<List<Designation>?> get_designation() async {
    final response = await http.get(Uri.parse(
        "http://phpstack-598410-2859373.cloudwaysapps.com/api/designations"));
    final data = jsonDecode(response.body) as List;
    if (response.statusCode == 200) {
      var users = data.map((e) => Designation.fromJson(e)).toList();
      log("Successfully fetched Designation list");
      return users;
    } else {
      log("fail to fetch Designation data");
    }
    return null;
  }

  Future create_designation({
    required String designationName,
  }) async {
    final response = await http.post(
        Uri.parse(
            "http://phpstack-598410-2859373.cloudwaysapps.com/api/designations"),
        body: {
          "name": designationName,
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Successfully Added new Designatiom');
    } else {
      log('Failed to Add Designation Field. ');
      log(response.statusCode.toString());
      return null;
    }
  }

  Future update_designation({
    required String id,
    required String designationName,
  }) async {
    log(id);
    final response = await http.put(
        Uri.parse(
            'http://phpstack-598410-2859373.cloudwaysapps.com/api/designations/$id'),
        body: {
          "name": designationName,
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Successfully updated Designation Data');
    } else {
      log('Failed to update Designation Data');
      log(response.statusCode.toString());
    }
    return null;
  }

  Future delete_designation({
    required String id,
  }) async {
    final response = await http.delete(
      Uri.parse(
          'http://phpstack-598410-2859373.cloudwaysapps.com/api/designations/$id'),
    );
    if (response.statusCode == 204) {
      log('Successfully delete Data');
    } else {
      log('Failed to PostData.');
      log(response.statusCode.toString());
    }
    return null;
  }

  Future<List<Department>?> get_department() async {
    final response = await http.get(Uri.parse(
        "http://phpstack-598410-2859373.cloudwaysapps.com/api/departments"));
    final data = jsonDecode(response.body) as List;
    if (response.statusCode == 200) {
      var users = data.map((e) => Department.fromJson(e)).toList();
      log("Successfully fetched Department list");
      return users;
    } else {
      log("fail to fetch Department data");
    }
    return null;
  }

  Future create_department({
    required String departmentName,
  }) async {
    final response = await http.post(
        Uri.parse(
            "http://phpstack-598410-2859373.cloudwaysapps.com/api/departments"),
        body: {
          "name": departmentName,
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Successfully Added new Department');
    } else {
      log('Failed to Add Department Field. ');
      log(response.statusCode.toString());
      return null;
    }
  }

  Future update_department({
    required String id,
    required String departmentName,
  }) async {
    log(id);
    final response = await http.put(
        Uri.parse(
            'http://phpstack-598410-2859373.cloudwaysapps.com/api/departments/$id'),
        body: {
          "name": departmentName,
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Successfully updated Department Data');
    } else {
      log('Failed to update Department Data');
      log(response.statusCode.toString());
    }
    return null;
  }

  Future delete_department({
    required String id,
  }) async {
    final response = await http.delete(
      Uri.parse(
          'http://phpstack-598410-2859373.cloudwaysapps.com/api/departments/$id'),
    );
    if (response.statusCode == 204) {
      log('Successfully deleted Department Data');
    } else {
      log('Failed to delete Department Data.');
      log(response.statusCode.toString());
    }
    return null;
  }
}
