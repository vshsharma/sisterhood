import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/utill/app_constants.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/custom_button.dart';
import 'package:sisterhood_app/utill/extension.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/sharedprefrence.dart';
import 'package:sisterhood_app/utill/styles.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();

  final _oldpassword = TextEditingController();
  final _newpassword = TextEditingController();
  final _confirmpassword = TextEditingController();
  bool isLoad = false;

  Future<void> _changePassword(String password) async {
    //Create an instance of the current user.

    FirebaseAuth user = await FirebaseAuth.instance;
    user.currentUser.updatePassword(password).then((_) {
      Fluttertoast.showToast(msg: context.loc.password_change_success);
      Navigator.pop(context);
    }).catchError((error) {
      print(context.loc.password_change_fail + error.toString());
    });

    /*setState(() {
       isLoad = false;
     });*/
  }

  bool _obscureText = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  String _password;

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
          // title: Image.asset(Images.logo,width: 50,),
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
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.loc.reset_password,
                          style: arialFont20W600ProfilePlaceHolder,
                        ),
                        SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(context.loc.old_password,
                                style: arialFont16W600),
                            SizedBox(
                              height: 5,
                            ),
                            _oldPasswordField(),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(context.loc.new_password,
                                style: arialFont16W600),
                            SizedBox(
                              height: 5,
                            ),
                            _newPasswordField(),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(context.loc.confirm_password,
                                style: arialFont16W600),
                            SizedBox(
                              height: 5,
                            ),
                            _confirmPasswordField(),
                          ],
                        ),
                        SizedBox(height: 120),
                        if (isLoad == true)
                          Center(child: CircularProgressIndicator())
                        else
                          _continuebutton(),
                        SizedBox(
                          height: 30,
                        ),
                      ]),
                ),
              )),
        )));
  }

  _continuebutton() {
    return GestureDetector(
      onTap: () async {
        if (_oldpassword.text.isEmpty) {
          Fluttertoast.showToast(msg: context.loc.enter_old_password);
        } else if (_newpassword.text.isEmpty) {
          Fluttertoast.showToast(msg: context.loc.enter_new_password);
        } else if (_newpassword.text.length < 8) {
          Fluttertoast.showToast(msg: context.loc.new_password_length);
        } else if (_confirmpassword.text.toString() !=
            _newpassword.text.toString()) {
          Fluttertoast.showToast(
              msg: context.loc.confirm_password_should_match);
        } else {
          var password =
              await SharedPrefManager.getPrefrenceString(AppConstants.password);
          if (password.toString() == _oldpassword.text.toString()) {
            setState(() {
              isLoad = true;
            });
            await _changePassword(_newpassword.text.toString());

            setState(() {
              isLoad = false;
            });
          } else {
            Fluttertoast.showToast(
                msg: context.loc.old_password_does_not_match);
          }
        }
      },
      child: CustomButton(
          text1: context.loc.save, text2: "", width: Get.width, height: 60),
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
                hintText: context.loc.old_password,
                hintStyle: arialFont16W600,
                errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              obscureText: _obscureText,
              validator: (value) {
                if (value.isEmpty) {
                  return context.loc.enter_old_password;
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
                hintText: context.loc.new_password,
                hintStyle: arialFont18W600,
                errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              obscureText: _obscureText1,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return context.loc.enter_new_password;
                }
                if (value.trim().length < 10) {
                  return context.loc.new_password_length;
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
              style: arialFont16W600,
              decoration: InputDecoration(
                hintText: context.loc.confirm_password,
                hintStyle: arialFont18W600,
                errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              obscureText: _obscureText2,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return context.loc.enter_confirm_password;
                }
                if (value != _newpassword.text) {
                  return context.loc.confirm_password_should_match;
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
