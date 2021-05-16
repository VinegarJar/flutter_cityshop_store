part of 'info_bloc.dart';

abstract class InfoEvent {}

class InfoChangeThemeEvent extends InfoEvent {
  final int counter;
  InfoChangeThemeEvent({this.counter});


}
