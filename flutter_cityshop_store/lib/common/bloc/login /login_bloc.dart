import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginSuccess());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginChangeEvent) {
      yield LoginSuccess(phoneNum: event.phoneNum);
    } else if (event is LoginCheckedEvent) {
      yield LoginChecked(checked: event.checked);
    }
  }
}
