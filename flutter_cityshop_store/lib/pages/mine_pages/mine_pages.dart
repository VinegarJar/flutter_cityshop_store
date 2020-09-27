import "package:flutter/cupertino.dart"; 

class MinePages extends StatefulWidget {
  MinePages({Key key}) : super(key: key);

  @override
  _MinePagesState createState() => _MinePagesState();
}

class _MinePagesState extends State<MinePages> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("我的"),
    );
  }
}