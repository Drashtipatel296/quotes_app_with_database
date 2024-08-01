import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_with_database/view/screens/home/home_screen.dart';

import 'controller/theme_controller.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeController.theme,
        home: HomeScreen(selectedCategories: [],),
      ),
    );
  }
}

