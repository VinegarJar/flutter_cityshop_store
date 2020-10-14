
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/buildback.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimationPages extends StatefulWidget {
  AnimationPages({Key key}) : super(key: key);

  @override
  _AnimationPagesState createState() => _AnimationPagesState();
}

class _AnimationPagesState extends State<AnimationPages> {


   @override
  void setState(fn) {

    super.setState(fn);
     showModalBottomSheet(context: null, builder: null);
  }
  
  @override
  Widget build(BuildContext context) {
    return 

    
    Scaffold(
  
        backgroundColor: Color.fromRGBO(169,169,169,0.3),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: null,
          actions: [
            BuildBackActions(
              title: "取消",
            )
          ],
          titleSpacing: 8,
  
          centerTitle: true, //标题居中显示
        ),
        body: Container(
          child: Text("hahha",),
          width: 300,
          height: 300,
          color: Colors.white,
        ),);
  }
}





class Page1 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          child: Text('Go!'),
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class Page2 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Page 2'),
      ),
    );
  }
}