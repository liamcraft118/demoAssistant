import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stardew_valley_assistant/utils/shared_preference_manager.dart';
import 'package:stardew_valley_assistant/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SharedPreferenceManager();
    return const GetMaterialApp(
      home: HomePage(),
    );
  }
}
