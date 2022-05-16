part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginChangeEvent extends LoginEvent {
  //event获取值
  final String phoneNum;
  LoginChangeEvent({@required this.phoneNum});
}
