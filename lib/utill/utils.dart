import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sisterhood_app/utill/strings.dart';
import 'package:sisterhood_app/utill/styles.dart';

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
      TextEditingController textEditingController) {
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
}
