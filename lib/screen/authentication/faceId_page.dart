import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/custom_button.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/strings.dart';

import '../../auth/local_auth_api.dart';

class FaceIdPage extends StatefulWidget {
  const FaceIdPage({Key key}) : super(key: key);

  @override
  _FaceIdPageState createState() => _FaceIdPageState();
}

class _FaceIdPageState extends State<FaceIdPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => localAuthCheck());
  }

  void localAuthCheck() async {
    final isAuthenticated = await LocalAuthApi.authenticate();
    if (isAuthenticated) {
      Get.to(const BottomNavigationPage(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 600));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.background,
        body: SafeArea(
            child: Center(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Image.asset(
                            Images.faceImage,
                            height: 85,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(Strings.faceid,
                              style: TextStyle(
                                color: ColorResources.black,
                                fontSize: 30,
                                letterSpacing: 1,
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // localAuthCheck();
                        Get.to(const BottomNavigationPage(),
                            transition: Transition.rightToLeftWithFade,
                            duration: const Duration(milliseconds: 600));
                      },
                      child: CustomButton(
                          text1: Strings.continueb,
                          text2: "",
                          width: Get.width,
                          height: 60),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )),
        )));
  }
}
