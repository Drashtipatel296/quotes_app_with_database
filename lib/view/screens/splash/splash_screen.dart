import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'intro_screen1.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 5),
      () => Get.to(IntroScreen1()),
    );
    return Scaffold(
      body: Center(
        child: Container(
          height: 240,
          width: 370,
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
