import 'package:event_bus/event_bus.dart';

//Bus初始化
EventBus eventBus = EventBus();

class UserTextFieldInEvent {
  String text;
  UserTextFieldInEvent(String text){
    this.text = text;
  }
}
