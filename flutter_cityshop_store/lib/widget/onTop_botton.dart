import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class OnTopBotton extends StatelessWidget {
  final VoidCallback callBack;
  final String title;
  final Widget widget;

  const OnTopBotton(
      {@required this.callBack, @required this.title, @required this.widget});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: widget,
        onTap: () {
          callBack?.call();
          if (title.isNotEmpty) {
            print('OnTopBotton----$title');
            _uploadFile();
          }
        });
  }

  //上传事件名称
  void _uploadFile() {}

  void createFile() async {
    // 获取应用文档目录并创建文件
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    File file = new File('$documentsPath/analytics');
    if (!file.existsSync()) {
      file.createSync();
    }
    writeToFile(file, title);
  }

  //将数据内容写入指定文件中
  void writeToFile(File file, String notes) async {
    File file1 = await file.writeAsString(notes);
    // File file1 = await file.writeAsBytesSync([notes]);
    file.writeAsBytesSync([]);
    if (file1.existsSync()) {
      print('保存成功');
    }
  }

  void getCacheFile() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    File file = new File('$documentsPath/analytics');
    if (!file.existsSync()) {
      return;
    }

    String notes = await file.readAsString();
    //读取到数据后设置数据更新UI
    print('读取到数据后设置数据更新UI--$notes');
  }

  void deleteOldCacheFile() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    Directory directory = new Directory('$documentsPath/analytics');

    if (directory is Directory || directory.existsSync()) {
      final List<FileSystemEntity> files = directory.listSync();
      for (final FileSystemEntity file in files) {
        file.deleteSync();
      }
    }
  }

  //json文件读写
  void writeToFileJson() async {
    var json1 = {'name': 'xiaoming', 'age': 22, 'address': 'hangzhou'};
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    File jsonFile = new File('$documentsPath/test.json');
    jsonFile.writeAsString(convert.jsonEncode(json1));

    // json文件读取
    var jsonStr = await jsonFile.readAsString();
    var json = convert.jsonDecode(jsonStr);
    print(json['name']); // xiaoming
    print(json['age']); // 22
    print(json['address']); // hangzhou

    //文件的拷贝
    File info1 = new File('$documentsPath/test/info.json');
    info1.copySync('$documentsPath/test2/info2.json');
  }
}
