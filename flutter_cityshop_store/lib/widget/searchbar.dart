import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//LoadingWidget loding.dart

typedef OnTapSearch = void Function();
typedef OnOpenCamera = void Function();

typedef OnTextFieldResults = void Function(String result);


class SearchBar extends StatefulWidget {
  final String searchFieldLabel;
  final OnTapSearch onTapSearch;
  final OnOpenCamera openCamera;
  final OnTextFieldResults textFieldResults;
  final bool isOpenCamera;
  final bool isTextField;
  final Color bgColor;

  const SearchBar(
      {Key key,
      this.searchFieldLabel = "热爱就现在 万店千城品牌日",
      this.onTapSearch,
      this.openCamera,
      this.isOpenCamera = false,
      this.bgColor = Colors.white,
      this.isTextField = false, 
      this.textFieldResults})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();



}

class _SearchBarState extends State<SearchBar> {

  final TextEditingController _queryTextController = TextEditingController();
  
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
     _queryTextController.addListener(_onQueryChanged);
     
  }

  @override
  void dispose() {
    super.dispose();
    _queryTextController.removeListener(_onQueryChanged);
    // _queryTextController.clear();

  }

  

  @override
  void didUpdateWidget(SearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget != oldWidget) {
       _queryTextController.removeListener(_onQueryChanged);
      _queryTextController.addListener(_onQueryChanged);

    }
  }



  void _onQueryChanged() {
    widget.textFieldResults(_queryTextController.text);

  }



  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 0, right: 0),
        height: ScreenUtil().setHeight(66),
        decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(ScreenUtil().setHeight(12))),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                child: Icon(CupertinoIcons.search,
                    size: 20, color: ThemeColors.titleColor),
                padding: EdgeInsets.all(widget.isTextField?3:5),
              ),
              Expanded(
                  child: InkWell(
                      onTap: () {
                        widget.onTapSearch();
                      },
                      child: widget.isTextField
                          ? TextField(
                            
                              controller: _queryTextController,
                              focusNode: focusNode,
                              textInputAction: TextInputAction.search,
                              keyboardType: TextInputType.text ,
                              autocorrect: true, //是否自动更正
                              autofocus: true, //是否自动对焦
                              obscureText: false, //是否是密码
                              textAlign: TextAlign.left, //文本对齐方式
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(32), color: Colors.black), //输入文本的样式
                              onSubmitted: (String result) {
                                widget.textFieldResults(result);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: widget.searchFieldLabel,
                                hintStyle: TextStyle(
                                  color: ThemeColors.titleColor,
                                  fontSize: ScreenUtil().setSp(26),
                                ),
                              ),
                            )
                          : Text(widget.searchFieldLabel,
                              style: TextStyle(
                                  color: ThemeColors.titleColor,
                                  fontSize: ScreenUtil().setSp(26))))),
              widget.isOpenCamera
                  ? InkWell(
                      onTap: () {
                        widget.openCamera();
                      },
                      child: Container(
                        child: Icon(CupertinoIcons.photo_camera,
                            size: 20, color: ThemeColors.titleColor),
                        padding: EdgeInsets.all(5),
                      ),
                    )
                  : Container()
            ]));
  }
}
