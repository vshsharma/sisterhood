import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/custom_button.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/styles.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  final _oldpassword = TextEditingController();
  final _newpassword = TextEditingController();
  final _confirmpassword = TextEditingController();

  bool _obscureText = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorResources.background,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 10),
            child: Column(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_left_outlined,
                      color: ColorResources.grey,
                      size: 35,
                    )),
              ],
            ),
          ),
          actions: [
            InkWell(
              onTap: () => exit(0),
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset(
                  Images.loginImage,
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
            child: Center(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _logo(),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context).new_password,
                                    style: arialFont16W400),
                                const SizedBox(
                                  height: 5,
                                ),
                                _newPasswordField(),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context).confirm_password,
                                    style: arialFont16W700),
                                const SizedBox(
                                  height: 5,
                                ),
                                _confirmPasswordField(),
                              ],
                            ),
                            const SizedBox(height: 120),
                            _continuebutton(),
                            const SizedBox(
                              height: 30,
                            ),
                          ]),
                    ),
                  ],
                ),
              )),
        )));
  }

  _logo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 90,
            // width: 180,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(Images.commonlogo)))),
        Container(
            height: 80,
            // width: 180,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(Images.Sisterhood)))),
      ],
    );
  }

  _continuebutton() {
    return GestureDetector(
      onTap: () {
        // Get.to(EditProfilePage(),
        // transition: Transition.rightToLeftWithFade,
        //   duration: Duration(milliseconds: 600)
        // );
      },
      child: CustomButton(
          text1: AppLocalizations.of(context).save, text2: "", width: Get.width, height: 60),
    );
  }

  _oldPasswordField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorResources.box_border,
          width: 1,
        ),
        color: ColorResources.box_background,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: TextFormField(
              controller: _oldpassword,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textAlignVertical: TextAlignVertical.bottom,
              style: arialFont18W600,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).old_password,
                hintStyle: arialFont18W600,
                errorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
              obscureText: _obscureText,
              validator: (value) {
                if (value.isEmpty) {
                  return AppLocalizations.of(context).please_enter_your_old_password;
                }
                return null;
              },
            ),
          ),
          InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Image.asset(
                Images.eyeImage,
                color: _obscureText ? ColorResources.black : Colors.red,
                scale: 4,
              ),
            ),
          )
        ],
      ),
    );
  }

  _newPasswordField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorResources.box_border,
          width: 1,
        ),
        color: ColorResources.box_background,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: TextFormField(
              controller: _newpassword,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textAlignVertical: TextAlignVertical.bottom,
              style: arialFont18W600,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).new_password,
                hintStyle: arialFont18W600,
                errorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
              obscureText: _obscureText1,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return AppLocalizations.of(context).please_enter_your_new_password;
                }
                if (value.trim().length < 8) {
                  return AppLocalizations.of(context).password_must_be_8_character;
                }
                return null;
              },
            ),
          ),
          InkWell(
            onTap: _toggle1,
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Image.asset(
                Images.eyeImage,
                color: _obscureText1 ? ColorResources.black : Colors.red,
                scale: 4,
              ),
            ),
          )
        ],
      ),
    );
  }

  _confirmPasswordField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorResources.box_border,
          width: 1,
        ),
        color: ColorResources.box_background,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: TextFormField(
              controller: _confirmpassword,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textAlignVertical: TextAlignVertical.bottom,
              style: arialFont18W600,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).confirm_password,
                hintStyle: arialFont18W600,
                errorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
              obscureText: _obscureText2,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return AppLocalizations.of(context).please_enter_confirm_password;
                }
                if (value != _newpassword.text) {
                  return AppLocalizations.of(context).confirm_password_not_match;
                }
                return null;
              },
            ),
          ),
          InkWell(
            onTap: _toggle2,
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Image.asset(
                Images.eyeImage,
                color: _obscureText2 ? ColorResources.black : Colors.red,
                scale: 4,
              ),
            ),
          )
        ],
      ),
    );
  }
}
