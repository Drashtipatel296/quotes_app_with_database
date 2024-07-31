import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_with_database/view/screens/home/category_screen.dart';
import 'package:quotes_app_with_database/view/screens/home/home_screen.dart';
import 'package:quotes_app_with_database/view/screens/home/wallpaper_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(selectedCategories: [],),
    );
  }
}

