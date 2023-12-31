import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/custom_button.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/utils.dart';

import '../../auth/local_auth_api.dart';
import '../../utill/dimension.dart';
import '../../utill/styles.dart';

class FaceIdPage extends StatefulWidget {
  const FaceIdPage({Key key}) : super(key: key);

  @override
  _FaceIdPageState createState() => _FaceIdPageState();
}

class _FaceIdPageState extends State<FaceIdPage> {
  BuildContext mContext;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => localAuthCheck());
  }

  void localAuthCheck() async {
    final isAuthenticated = await LocalAuthApi.authenticate(context);
    if (isAuthenticated) {
      Get.to(const BottomNavigationPage(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 600));
    } else {
      Utils.showSnackBar(
          context, AppLocalizations.of(context).local_auth_failed);
      await LocalAuthApi.stopAuthorization();
    }
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return Scaffold(
        backgroundColor: ColorResources.background,
        body: SafeArea(
            child: Center(
          child: Padding(
              padding: const EdgeInsets.all(dim_20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: dim_10,
                          ),
                          Image.asset(
                            Images.faceImage,
                            height: dim_85,
                          ),
                          const SizedBox(
                            height: dim_20,
                          ),
                          Text(AppLocalizations.of(context).face_id,
                              style: arialFont30W600Black),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        localAuthCheck();
                      },
                      child: CustomButton(
                          text1: AppLocalizations.of(context)
                              .authorize
                              .toUpperCase(),
                          text2: "",
                          width: Get.width,
                          height: dim_60),
                    ),
                    const SizedBox(
                      height: dim_20,
                    ),
                  ],
                ),
              )),
        )));
  }
}
