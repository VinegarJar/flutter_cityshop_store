part of 'login_bloc.dart';

abstract class LoginState {
  const LoginState();

  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  final String phoneNum;
  const LoginSuccess({this.phoneNum});

  @override
  List<Object> get props => [phoneNum];
}

class LoginChecked extends LoginState {
  final bool checked;
  LoginChecked({this.checked = false});

  @override
  List<Object> get props => [checked];
}
