import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/custom_button.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/styles.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final _username = TextEditingController();

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
          child: SingleChildScrollView(
              child: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  const SizedBox(height: 20),
                  _logo(),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorResources.box_border,
                        width: 1.5,
                      ),
                      color: ColorResources.box_background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 55,
                    alignment: Alignment.bottomLeft,
                    child: TextFormField(
                      controller: _username,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(
                          Images.smsImage,
                          scale: 4.0,
                        ),
                        hintText: AppLocalizations.of(context).email,
                        hintStyle: arialFont16W700,
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                      ),
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return AppLocalizations.of(context)
                              .plese_enter_user_name;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 80),
                  InkWell(
                    onTap: () async {
                      if (_username.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: AppLocalizations.of(context)
                                .please_enter_email);
                      } else {
                        final list = await FirebaseAuth.instance
                            .fetchSignInMethodsForEmail(
                                _username.text.toString());

                        if (list.isNotEmpty) {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email: _username.text.toString())
                              .then((value) {
                            Fluttertoast.showToast(
                                msg: AppLocalizations.of(context).link_sent);
                            Navigator.of(context).pop();
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: AppLocalizations.of(context)
                                  .user_not_existing);
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CustomButton(
                          text1: AppLocalizations.of(context).get_email,
                          text2: "",
                          width: Get.width,
                          height: 50),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 2, width: 60, color: Colors.black12),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.black12,
                        child: Text(
                          AppLocalizations.of(context).or,
                          style: const TextStyle(
                              color: ColorResources.black,
                              fontFamily: "Roboto",
                              fontSize: 12),
                        ),
                      ),
                      Container(height: 2, width: 60, color: Colors.black12),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            gradient: const LinearGradient(colors: [
                              Colors.white,
                              Colors.white,
                            ]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 50,
                          width: Get.width,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                      AppLocalizations.of(context).go_to_login,
                                      style: const TextStyle(
                                        color: ColorResources.black,
                                        fontSize: 16,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ]),
              ),
            ),
          )),
        ));
  }

  _logo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              height: 90,
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(Images.commonlogo)))),
        ),
        Container(
            height: 80,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(Images.Sisterhood)))),
      ],
    );
  }
}
