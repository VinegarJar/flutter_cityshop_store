import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cityshop_store/bloc/info_bloc.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
class MinePages extends StatefulWidget {
  MinePages({Key key}) : super(key: key);

  @override
  _MinePagesState createState() => _MinePagesState();
}

class _MinePagesState extends State<MinePages> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => InfoBloc(),
      child: MyHomePage(title: 'Flutter的Bloc使用'),
    );
  }

}


class MyHomePage extends StatefulWidget {
  MyHomePage({this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 1;

  void _incrementCounter() {

      BlocProvider.of<InfoBloc>(context).add(InfoChangeThemeEvent(counter: _counter++));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: ThemeColors.mainBgColor,
      appBar: AppBar(
         backgroundColor: ThemeColors.mainColor,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      // body: BlocProvider(
      //   create: (BuildContext context) => InfoBloc(),
      //   child: Center(
      //     // Center is a layout widget. It takes a single child and positions it
      //     // in the middle of the parent.
      //     child:InCounter() ,
      //   ),
      // ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child:InCounter() ,
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// ignore: must_be_immutable
class InCounter extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoBloc, InfoState>(builder: (context, state) {
          // print("----build方法执行---${state.counter}");
      return Container(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '你可以按很多次了:',
          ),
          Text(
            '增加编号数据:${state.counter}',
            style: Theme.of(context).textTheme.headline4,
            
          ),


        ],
      ));
    });
  }
}

