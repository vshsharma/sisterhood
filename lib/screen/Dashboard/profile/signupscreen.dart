import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_button.dart';
import '../../../utill/email_validation.dart';
import '../../../utill/images.dart';
import '../../../utill/sharedprefrence.dart';
import '../../../utill/styles.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _form1Key = GlobalKey<FormState>();
  final _form2Key = GlobalKey<FormState>();
  final _form3Key = GlobalKey<FormState>();
  final _form4Key = GlobalKey<FormState>();
  final _form5Key = GlobalKey<FormState>();
  final _form6Key = GlobalKey<FormState>();
  final _form7Key = GlobalKey<FormState>();
  final _form8Key = GlobalKey<FormState>();
  final _form9Key = GlobalKey<FormState>();
  final _form10Key = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool _isLoad = false;
  final _firstName = TextEditingController();
  final _password = TextEditingController();
  final _middleName = TextEditingController();
  final _lastName = TextEditingController();
  final _emailAddress = TextEditingController();
  final _userName = TextEditingController();
  final _addressController = TextEditingController();
  final _city = TextEditingController();
  final _zipCode = TextEditingController();

  bool isEmail(em) {
    var p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  Future<UserCredential> _trySubmit() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential user;
    if (_formKey.currentState.validate()) {
      if (_form1Key.currentState.validate()) {
        if (_form2Key.currentState.validate()) {
          if (_form3Key.currentState.validate()) {
            if (_form4Key.currentState.validate()) {
              if (_form5Key.currentState.validate()) {
                if (_form6Key.currentState.validate()) {
                  if (_form7Key.currentState.validate()) {
                    try {
                      setState(() {
                        _isLoad = true;
                      });
                      user = await _auth.createUserWithEmailAndPassword(
                          email: _emailAddress.text.toString(),
                          password: _password.text.toString());
                      var methods = await FirebaseAuth.instance
                          .fetchSignInMethodsForEmail(
                              _emailAddress.text.toString());
                      if (methods.contains(_password.text.toString())) {
                      } else {
                        Fluttertoast.showToast(
                            msg: AppLocalizations.of(context)
                                .registered_successfully);
                        Get.back();
                      }
                      setState(() {
                        _isLoad = false;
                      });
                      user.user.updateDisplayName(_userName.text.toString());
                      Map<String, dynamic> newcreate = {};
                      Map<String, dynamic> create = {
                        'username': _userName.text.toString(),
                        'firstname': _firstName.text.toString(),
                        'middleName': '',
                        'lastname': _lastName.text.toString(),
                        'mobile': '',
                        'address': _addressController.text.toString(),
                        'city': _city.text.toString(),
                        'zipcode': _zipCode.text.toString(),
                        'image_url': '',
                        'member': DateTime.now().year.toString(),
                        'updatedDate': DateTime.now().day.toString() +
                            "/" +
                            DateTime.now().month.toString() +
                            "/" +
                            DateTime.now().year.toString()
                      };
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.user.uid)
                          .set(create);
                      await SharedPrefManager.savePreferenceBoolean(true);
                      await SharedPrefManager.savePrefString(
                          AppConstants.password, _password.text.toString());
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print(AppLocalizations.of(context).weak_password);

                        Fluttertoast.showToast(
                            msg: AppLocalizations.of(context).weak_password);
                        setState(() {
                          _isLoad = false;
                        });
                      } else if (e.code == 'email-already-in-use') {
                        print(AppLocalizations.of(context).account_exist);
                        setState(() {
                          _isLoad = false;
                        });
                        Fluttertoast.showToast(
                            msg: AppLocalizations.of(context).account_exist);
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    return user;
  }

  _continuebutton() {
    return GestureDetector(
      onTap: () {
        _trySubmit();
      },
      child: CustomButton(
          text1: AppLocalizations.of(context).signup,
          text2: "",
          width: Get.width,
          height: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    _firstnameField() {
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
        child: Form(
          key: _formKey,
          child: TextFormField(
            controller: _firstName,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.bottom,
            style: arialFont18W600,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).first_name,
              hintStyle: arialFont18W600,
              errorBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context).plese_enter_first_name;
              }
              return null;
            },
          ),
        ),
      );
    }

    _lastnameField() {
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
        child: Form(
          key: _form1Key,
          child: TextFormField(
            controller: _lastName,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.bottom,
            style: arialFont18W600,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).last_name,
              hintStyle: arialFont18W600,
              errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context).plese_enter_last_name;
              }
              return null;
            },
          ),
        ),
      );
    }

    _emailaddressField() {
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
        child: Form(
          key: _form3Key,
          child: TextFormField(
            controller: _emailAddress,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.bottom,
            style: arialFont18W600,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).email_address,
              hintStyle: arialFont18W600,
              errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) => validateEmail(value),
          ),
        ),
      );
    }

    _passwordField() {
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
        child: Form(
          key: _form4Key,
          child: TextFormField(
            controller: _password,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.bottom,
            style: arialFont18W600,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).password,
              hintStyle: arialFont18W600,
              errorBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context).please_enter_password;
              } else if (value.length < 10) {
                return AppLocalizations.of(context).please_min_length;
              }
              return null;
            },
          ),
        ),
      );
    }

    _usernameField() {
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
        child: Form(
          key: _form2Key,
          child: TextFormField(
            controller: _userName,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.bottom,
            style: arialFont18W600,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).user_name,
              hintStyle: arialFont18W600,
              errorBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context).plese_enter_user_name;
              }
              return null;
            },
          ),
        ),
      );
    }

    _phoneNumberField() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorResources.box_border,
            width: 1,
          ),
          color: ColorResources.box_background,
          borderRadius: BorderRadius.circular(10),
        ),
        // height: 60,
        alignment: Alignment.topCenter,
        child: Form(
          key: _form5Key,
          child: TextFormField(
            controller: _addressController,
            textAlign: TextAlign.start,
            maxLines: 2,
            keyboardType: TextInputType.streetAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.bottom,
            style: arialFont18W600,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).address,
              hintStyle: arialFont18W600,
              errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context).plese_enter_your_address;
              }
              return null;
            },
          ),
        ),
      );
    }

    _cityField() {
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
        child: Form(
          key: _form6Key,
          child: TextFormField(
            controller: _city,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.bottom,
            style: arialFont18W600,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).city,
              hintStyle: arialFont18W600,
              errorBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context).please_enter_city;
              }
              return null;
            },
          ),
        ),
      );
    }

    _zipcodeField() {
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
        child: Form(
          key: _form7Key,
          child: TextFormField(
            controller: _zipCode,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.bottom,
            style: arialFont18W600,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).zip_code,
              hintStyle: arialFont18W600,
              errorBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context).plese_enter_your_zip_code;
              }
              return null;
            },
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: ColorResources.background,
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                // key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      // SizedBox(height: 70),

                      const SizedBox(height: 30),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).first_name,
                            style: arialFont16W700,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          _firstnameField(),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context).last_name,
                              style: arialFont16W700),
                          const SizedBox(
                            height: 5,
                          ),
                          _lastnameField(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).user_name,
                            style: arialFont16W700,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          _usernameField(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).email,
                            style: arialFont16W700,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          _emailaddressField(),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).password,
                            style: arialFont16W700,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          _passwordField(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).address,
                            style: arialFont16W700,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          _phoneNumberField(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).city,
                            style: arialFont16W700,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          _cityField(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).zip_code,
                            style: arialFont16W700,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          _zipcodeField(),
                        ],
                      ),
                      const SizedBox(height: 30),

                      if (_isLoad)
                        const Center(child: CircularProgressIndicator())
                      else
                        _continuebutton(),

                      // const SizedBox(height: 30,),

                      Container(
                        alignment: Alignment.center,
                        child: TextButton(
                            onPressed: () {
                              Get.back();
                              /*Get.to(const LoginPage(),
                            transition: Transition.rightToLeftWithFade,
                            duration: const Duration(milliseconds: 600));*/
                            },
                            child: const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Already Account? ',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal)),
                                  TextSpan(
                                      text: ' Login',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 15)),
                                ],
                              ),
                            )),
                      ),
                    ]),
              ),
            )));
  }
}
