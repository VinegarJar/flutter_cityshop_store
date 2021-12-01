part of 'login_bloc.dart';

abstract class AppState {}

class LoginState extends AppState {
  final String phoneNum ;
  LoginState({this.phoneNum});

  LoginState copyWith({String phoneNum}) {
    // print("----copyWith方法传递过来的值---$phoneNum");
    return LoginState(phoneNum:phoneNum);
  }
}
