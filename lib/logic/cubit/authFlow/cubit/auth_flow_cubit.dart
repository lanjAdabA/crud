import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_flow_state.dart';

class AuthFlowCubit extends Cubit<AuthFlowState> {
  AuthFlowCubit() : super(const AuthFlowState(status: LoginStatus.initial));
  void getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("token")) {
      emit(const AuthFlowState(status: LoginStatus.login));
    } else {
      emit(const AuthFlowState(status: LoginStatus.logout));
    }
  }
}
