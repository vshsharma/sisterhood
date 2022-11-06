import 'dart:async';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/screen/authentication/login_page.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(
        const Duration(seconds: 4), () => Get.offAll(() => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      body: Center(
        child: DelayedDisplay(
          delay: const Duration(seconds: 1),
          child: Image.asset(
            Images.splash_image,
            width: Get.width,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
