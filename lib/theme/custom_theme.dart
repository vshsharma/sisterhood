import 'package:flutter/material.dart';
import 'package:sisterhood_app/utill/color_resources.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: ColorResources.grey,
        scaffoldBackgroundColor: ColorResources.white,
        fontFamily: 'Courier',
        buttonTheme: ButtonThemeData(
          // 4
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: ColorResources.background,
        ));
  }
}
