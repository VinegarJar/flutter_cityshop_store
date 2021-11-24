part of 'info_bloc.dart';


abstract class AppState{}


class InfoState extends AppState{
 
  final int counter;
  InfoState({this.counter});

  
  InfoState copyWith({
    int counter
  }) {
     print("----copyWith方法传递过来的值---$counter");
     return InfoState(counter:counter);
  }

}
