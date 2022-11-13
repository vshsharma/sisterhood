import 'dart:core';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/utill/app_constants.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/custom_button.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/sharedprefrence.dart';

import '../../utill/styles.dart';
import '../Dashboard/profile/signupscreen.dart';
import 'faceId_page.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  final _password = TextEditingController();
  bool rememberMe = false;

  bool _isLoad = false;

  bool isEmail(em) {
    return RegExp(AppConstants.email_pattern).hasMatch(em);
  }

  void trySubmit() async {
    if (isEmail(username.text)) {
      if (_formKey.currentState.validate()) {
        setState(() {
          _isLoad = true;
        });

        final list = await FirebaseAuth.instance
            .fetchSignInMethodsForEmail(username.text.toString());

        if (list.isNotEmpty) {
          try {
            final user = await _auth.signInWithEmailAndPassword(
                email: username.text.toString(),
                password: _password.text.toString());
            if (user != null) {
              await SharedPrefManager.savePreferenceBoolean(true);
              await SharedPrefManager.savePrefString(
                  AppConstants.password, _password.text.toString());
              Get.offAll(() => const FaceIdPage());
            }
          } on FirebaseAuthException catch (e) {
            //Here you catch the specific error
            if (e.code == 'wrong-password') {
              //The thing that should happen if the password is incorrect
              //In my case it will the change the hinttext
              setState(() {
                // print('Password incorrect. Please try again');
                Fluttertoast.showToast(
                    msg: AppLocalizations.of(context).enter_valid_password);
                // passwordHintColor = Colors.red;
              });
            } else if (e.code == 'user-not-found') {
              setState(() {
                print(AppLocalizations.of(context).no_user_found_error);
                // emailHintColor = Colors.red;
              });
            }
          } catch (e) {
            print(e);
          }
        } else {
          Fluttertoast.showToast(
              msg: AppLocalizations.of(context).invalid_credential);
        }
        setState(() {
          _isLoad = false;
        });
      }
    } else {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context).enter_valid_email);
    }
  }

  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.background,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(children: [
                      const SizedBox(height: 30),
                      Image.asset(
                        Images.commonlogo,
                        width: Get.width,
                        height: 94,
                      ),
                      Image.asset(
                        Images.Sisterhood,
                        width: Get.width,
                        height: 70,
                      ),
                      SizedBox(height: 70),
                      mobileNo(),
                      const SizedBox(height: 20),
                      passwordField(),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              Get.to(const ForgotPasswordPage(),
                                  transition: Transition.rightToLeftWithFade,
                                  duration: const Duration(milliseconds: 600));
                            },
                            child: Text(
                                AppLocalizations.of(context).forgot_password,
                                style: roboto16BoldGrey)),
                      ),
                      const SizedBox(height: 40),
                      if (_isLoad == true)
                        const SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator())
                      else
                        continueButton(),
                      Container(
                        alignment: Alignment.center,
                        child: TextButton(
                            onPressed: () {
                              Get.to(const SignupScreen(),
                                  transition: Transition.rightToLeftWithFade,
                                  duration: const Duration(milliseconds: 600));
                            },
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: AppLocalizations.of(context)
                                          .dont_have_account,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal)),
                                  TextSpan(
                                      text:
                                          AppLocalizations.of(context).sign_up,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 15)),
                                ],
                              ),
                            )),
                      ),
                      const SizedBox(height: 20),
                    ]),
                  ),
                ))));
  }

  continueButton() {
    return GestureDetector(
      onTap: () {
        trySubmit();
      },
      child: CustomButton(
          text1: AppLocalizations.of(context).log_in,
          text2: "",
          width: Get.width,
          height: 60),
    );
  }

  mobileNo() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorResources.box_border,
          width: 1.5,
        ),
        color: ColorResources.box_background,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      alignment: Alignment.bottomLeft,
      child: TextFormField(
        controller: username,
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
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        validator: (value) => EmailValidator.validate(value)
            ? null
            : AppLocalizations.of(context).enter_valid_email,
      ),
    );
  }

  passwordField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorResources.box_border,
          width: 1.5,
        ),
        color: ColorResources.box_background,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      alignment: Alignment.bottomLeft,
      child: TextFormField(
        controller: _password,
        keyboardType: TextInputType.text,
        obscureText: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          prefixIcon: Image.asset(
            Images.lockImage,
            scale: 4.0,
          ),
          hintText: AppLocalizations.of(context).password,
          hintStyle: arialFont16W700,
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return AppLocalizations.of(context).empty_password;
          } else if (value.length < 10) {
            return AppLocalizations.of(context).password_length;
          }
          return null;
        },
      ),
    );
  }
}
