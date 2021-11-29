part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginChangeEvent extends LoginEvent {
  //event获取值
  final int counter;
  LoginChangeEvent({this.counter});
}
