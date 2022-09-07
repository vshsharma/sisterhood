import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sisterhood_app/screen/women_shelter/model/women_shelter_model.dart';
import 'package:sisterhood_app/utill/strings.dart';
import 'package:sisterhood_app/utill/styles.dart';
import 'package:url_launcher/url_launcher.dart';

import 'color_resources.dart';
import 'custom_button.dart';
import 'dimension.dart';

class Utils {
  static List<Widget> modelBuilder<M>(
          List<M> models, Widget Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();

  static void showSheet(
    BuildContext context, {
    Widget child,
    VoidCallback onClicked,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            child,
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Done'),
            onPressed: onClicked,
          ),
        ),
      );

  static void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text,
          style: courierFont20W600.copyWith(color: ColorResources.white)),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void genericPopUp(BuildContext context, String titleText) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ColorResources.background,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: ColorResources.black,
                      size: dim_20,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Text(
                  titleText,
                  style: courierFont18W600,
                ),
                const SizedBox(
                  height: dim_40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: dim_25),
                      child: CustomButton(
                          text1: Strings.close,
                          text2: "",
                          width: Get.width,
                          height: dim_50)),
                )
              ],
            ),
          );
        });
  }

  static void genericInputPopUp(BuildContext context, String titleText,
      TextEditingController textEditingController, FocusNode focusNode) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ColorResources.background,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: ColorResources.black,
                      size: dim_20,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Text(
                  titleText,
                  style: courierFont18W600,
                ),
                const SizedBox(
                  height: dim_10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorResources.box_border,
                      width: dim_1,
                    ),
                    color: ColorResources.box_background,
                    borderRadius: BorderRadius.circular(dim_10),
                  ),
                  height: dim_100,
                  alignment: Alignment.topCenter,
                  child: TextFormField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textAlignVertical: TextAlignVertical.bottom,
                    style: arialFont14W600,
                    decoration: const InputDecoration(
                      hintText: Strings.write_here,
                      hintStyle: arialFont14W600,
                      errorBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Empty";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: dim_40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: dim_25),
                      child: CustomButton(
                          text1: Strings.submit,
                          text2: "",
                          width: Get.width,
                          height: dim_50)),
                )
              ],
            ),
          );
        });
  }

  static void genericInputPopUpNoTitle(
      BuildContext context, TextEditingController textEditingController) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ColorResources.background,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: ColorResources.black,
                      size: dim_20,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorResources.box_border,
                      width: dim_1,
                    ),
                    color: ColorResources.box_background,
                    borderRadius: BorderRadius.circular(dim_10),
                  ),
                  height: dim_100,
                  alignment: Alignment.topCenter,
                  child: TextFormField(
                    controller: textEditingController,
                    textAlign: TextAlign.start,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textAlignVertical: TextAlignVertical.bottom,
                    style: arialFont14W600,
                    decoration: const InputDecoration(
                      hintText: Strings.write_here,
                      hintStyle: arialFont14W600,
                      errorBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Empty";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: dim_30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: dim_25),
                      child: CustomButton(
                          text1: Strings.submit,
                          text2: "",
                          width: Get.width,
                          height: dim_50)),
                )
              ],
            ),
          );
        });
  }

  static void log(String message) {
    if (kDebugMode) {
      print("Available biometrics $message");
    }
  }

  static Future<List<WomenShelterModel>> loadJson() async {
    String data = await rootBundle.loadString('assets/json/shelters.json');
    Iterable l = json.decode(data);
    List<WomenShelterModel> shelterList = List<WomenShelterModel>.from(
        l.map((model) => WomenShelterModel.fromJson(model)));
    return shelterList;
  }

  static void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static Future<void> launchInWebViewWithoutJavaScript(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
    )) {
      throw 'Could not launch $url';
    }
  }
}
