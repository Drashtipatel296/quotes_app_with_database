import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'intro_screen1.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 4),
      () => Get.to(const IntroScreen1()),
    );
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 240,
          width: 370,
          child: Image.asset(
            'assets/logo-removebg-preview.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
