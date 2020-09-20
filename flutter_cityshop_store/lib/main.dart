import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cityshop_store/view/splash_screen_page.dart';
import 'package:flutter_cityshop_store/widget/appbar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

/**方式一实现Provider使用Consumer 方式 */

main() {
  runApp(ChangeNotifierProvider<CounterNotifier>.value(
    value: CounterNotifier(),
    child: MyApp(),
  ));


  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
       //这是设置状态栏的图标和字体的颜色  
       statusBarColor: Colors.orange,
       statusBarIconBrightness: Brightness.dark
    );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: 36),
        ChangeNotifierProvider.value(value: CounterNotifier())
      ],
      child: MaterialApp(
        title: 'Privoder Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: Page1(),
      ),
    );

 }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //获取文字大小
    final size = Provider.of<int>(context).toDouble();
    // 获取计数
    final counter = Provider.of<CounterNotifier>(context);
    // 调用 build 时输出
    print('rebuild page 1');
    return Scaffold(
      appBar: AppBarWidget(title:'Page1',canBack:false).build(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 显示计数
            Text(
              'Current count: ${counter.count}',
              // 设置文字大小
              style: TextStyle(
                fontSize: size,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            // 跳转 Page2
            RaisedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Page2()),
              ),
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}


class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('rebuild page 2');
    return Scaffold(
      appBar: AppBarWidget(title:'Page2').build(context),
    
      body: Center(
        child: Consumer2<CounterNotifier, int>(
            builder: (context, counter, size, _) {
              print('rebuild page 2 refresh count');

              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${counter.count}',
                    style: TextStyle(
                      fontSize: size.toDouble(),
                    ),
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 不需要监听改变（listen: false 不会重新调用build）
          Provider.of<CounterNotifier>(context, listen: false).increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}


class CounterNotifier with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  increment() {
    _count++;
    notifyListeners();
  }
}

/**方式二实现Provider使用CounterNotifier 数据 （最简单的方式） 方式 */
/*
void main() {
    runApp(MyApp());
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
       //这是设置状态栏的图标和字体的颜色  
       statusBarColor: Colors.blue,
       statusBarIconBrightness: Brightness.dark
    );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: CounterNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, //关闭显示debug模式
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProvidePage(title: 'Provider 测试页面'), //SplashScreenPage(),
      ),
    );
  }
}

class ProvidePage extends StatelessWidget {
  final String title;

  ProvidePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取 CounterNotifier 数据 （最简单的方式）
    final counter = Provider.of<CounterNotifier>(context);

    return Scaffold(
      appBar: AppBarWidget(title: title, canBack: false).build(context),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '按下按钮，使数字增长:',
            ),
            Text(
              '${counter.count}',
              // ignore: deprecated_member_use
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

//  核心：继承自ChangeNotifier
// 这种文件本来应该单独放在一个类文件连的
class CounterNotifier with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  increment() {
    _count++;
    // 核心方法，通知刷新UI,调用build方法
    print("核心方法，通知刷新UI,调用build方法");
    notifyListeners();
  }
}
*/
