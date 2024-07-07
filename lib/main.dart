import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:time_manage/pages/homepg.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('main');
  runApp(MainApp(
    box: box,
  ));
}

class MainApp extends StatelessWidget {
  MainApp({
    super.key,
    required this.box,
  });
  final Box<dynamic> box;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePg(
        box: box,
      ),
    );
  }
}
