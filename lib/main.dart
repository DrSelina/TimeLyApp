import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:time_manage/pages/homepg.dart';

void main() {
  runApp(MainApp());
  HiveSync();
}

void HiveSync() async {
  await Hive.initFlutter();
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePg(
      ),
    );
  }
}
