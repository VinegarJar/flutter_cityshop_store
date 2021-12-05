import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/model/homerecommed.dart';
import 'package:flutter_cityshop_store/widget/item.dart';

class HomeListPage extends StatefulWidget {
  final List dataSource;
  const HomeListPage({Key key, @required this.dataSource}) : super(key: key);

  @override
  _HomeListPageState createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage> {


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
      physics:NeverScrollableScrollPhysics(),//禁用滑动事件
      itemCount: widget.dataSource.length,
      itemBuilder: (BuildContext context, int index) {
        HomeRecommed model = widget.dataSource[index];
        return Item(model: model);
      },
    );
  }
}
