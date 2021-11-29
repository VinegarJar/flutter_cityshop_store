part of 'login_bloc.dart';

abstract class AppState {}

class LoginState extends AppState {
  final String name;
  LoginState({this.name});

  LoginState copyWith({String name}) {
    print("----copyWith方法传递过来的值---$name");
    return LoginState(name: name);
  }
}
