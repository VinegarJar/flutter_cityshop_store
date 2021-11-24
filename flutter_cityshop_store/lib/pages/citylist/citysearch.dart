import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/model/models.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/buildback.dart';
import 'package:flutter_cityshop_store/widget/searchbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CitySearchResult extends StatefulWidget {
  final List<CityModel> cityList;
  CitySearchResult({Key key, this.cityList}) : super(key: key);

  @override
  _CitySearchResultState createState() => _CitySearchResultState();
}

class _CitySearchResultState extends State<CitySearchResult> {
  String query = "";

  final recentCities = [
    CityModel(name: ""),
    CityModel(name: ""),
    CityModel(name: ""),
    CityModel(name: ""),
    CityModel(name: ""),
    CityModel(name: ""),
    CityModel(name: ""),
    CityModel(name: ""),
    CityModel(name: ""),
    CityModel(name: ""),
  ];

  @override
  void initState() {
    super.initState();
  
  
  }

  @override
  Widget build(BuildContext context) {
    List list =
        widget.cityList.where((model) => model.name.contains(query)).toList();
    final results = query.isEmpty
        ? recentCities
        : list.where((model) => model.name.startsWith(query)).toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: null,
        actions: [BuildBackActions()],
        titleSpacing: 8,
        title: SearchBar(
            searchFieldLabel: "城市搜索",
            bgColor: ThemeColors.mainBgColor,
            isTextField: true,
            textFieldResults: (String result) {
              setState(() {
                // rebuild ourselves because query changed.
                query = result;
              });
            }),
        centerTitle: true, //标题居中显示
      ),
      body: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    print(" onTap===${results[index].name}");
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    height: ScreenUtil().setHeight(88),
                    child: Text(
                      results[index].name,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child:Divider(
                  height: .0,
                ) ,
                ),
                
              ],
            );
          }),
    );
  }
}
