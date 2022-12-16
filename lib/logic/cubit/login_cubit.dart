import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:crud/models/token.model.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState(status: Status.initial));
  bool get isloading => Status.loading == state.status;
  void loginUser({
    required String username,
    required String password,
  }) async {
    if (isloading) return;
    emit(const LoginState(status: Status.loading));
    final prefs = await SharedPreferences.getInstance();
    final body = {"username": username, "password": password};
    try {
      final response = await http.post(
          Uri.parse(
              "http://phpstack-598410-2859373.cloudwaysapps.com/api/login"),
          body: jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final token = TokenModel.fromJson(data);
        prefs.setString("token", token.token);
        emit(const LoginState(status: Status.loaded));
      } else {
        emit(const LoginState(status: Status.error));
        log(response.statusCode.toString());
        return null;
      }
    } catch (e) {
      emit(const LoginState(status: Status.error));
    }
  }
}
