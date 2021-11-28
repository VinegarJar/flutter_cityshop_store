import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cityshop_store/common/bloc/info_bloc.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
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

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 1;

  _MyHomePageState() {
    print('私有构造函数--${this._counter}');
  }

  @override
  void initState() {
    super.initState();
    print('initState--${this._counter}');
  }

  void _incrementCounter() {
    BlocProvider.of<InfoBloc>(context)
        .add(InfoChangeThemeEvent(counter: _counter++));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.mainBgColor,
      appBar: AppBar(
        backgroundColor: ThemeColors.mainColor,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: InCounter(),
      ),
      floatingActionButton: FloatingActionButton(
         onPressed: () {
          //Navigator.pushReplacementNamed(context, 'index');
          NavigatorUtils.goLogin(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

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
          Text('增加编号数据:${state.counter}',
              style: Theme.of(context).textTheme.headline4),
        ],
      ));
    });
  }
}

class Person {
  //声明的属性
  String name = "章三";

  String getUser() {
    return this.name;
  }

  get getUserNames {
    return this.name;
  }

  //set 赋值
  set setUserName(String name) {
    this.name = name;
  }

  //声明方法
  getUserInfo() {
    print('声明方法触发--${this.name}');
  }

  //构造函数,初始化的时候可以对变量赋值
  Person({@required String name}) {
    print('构造函数默认name--${this.name}');
    this.name = name;
    print('构造函数在实立化触发--${this.name}');
  }
}
