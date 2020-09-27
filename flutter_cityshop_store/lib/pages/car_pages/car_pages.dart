import "package:flutter/cupertino.dart"; 

class CarPages extends StatefulWidget {
  CarPages({Key key}) : super(key: key);

  @override
  _CarPagesState createState() => _CarPagesState();
}

class _CarPagesState extends State<CarPages> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("购物车")
    );
  }
}