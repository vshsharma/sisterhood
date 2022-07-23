import 'dart:async';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/screen/authentication/login_page.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/images.dart';

import '../Dashboard/Home/viewHistory/journal_history_list.dart';

class SplashPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    // if(mounted){
    Timer(
        // const Duration(seconds: 4), () => Get.offAll(()=>const SignupScreen())
        const Duration(seconds: 4), () => Get.offAll(()=>const LoginPage())
    );
  }


  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: ColorResources.background,
    //   body: StreamBuilder(
    //     stream: _auth.authStateChanges(),
    //       builder: (BuildContext context,snapshot){
    //         if(snapshot.hasData){
    //           return const BottomNavigationPage();
    //         }else{
    //           return const LoginPage();
    //         }
    //         // return SplashPage();
    //       }
    //   ),
    // );
    return Scaffold(
      backgroundColor: ColorResources.background,
      body: Center(
        child: DelayedDisplay(
          delay: Duration(seconds: 1),
          child: Image.asset(Images.splash_image,
            width: Get.width,
            fit: BoxFit.fill,),
        ),
      ),
    );
  }
}