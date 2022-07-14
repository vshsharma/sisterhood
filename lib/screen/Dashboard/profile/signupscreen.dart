import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/screen/authentication/login_page.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_button.dart';
import '../../../utill/email_validation.dart';
import '../../../utill/images.dart';
import '../../../utill/sharedprefrence.dart';
import '../../../utill/strings.dart';

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
    var p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  Future<UserCredential> _trySubmit() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential user;
    if(_formKey.currentState.validate()) {
     if(_form1Key.currentState.validate()){
      if(_form2Key.currentState.validate()) {
      if(_form3Key.currentState.validate()) {
        if(_form4Key.currentState.validate()) {
          if(_form5Key.currentState.validate()) {
            if(_form6Key.currentState.validate()) {
              if(_form7Key.currentState.validate()) {

                try {
                  setState(() {
                    _isLoad = true;
                  });
                  user = await _auth.createUserWithEmailAndPassword(
                      email: _emailAddress.text.toString(),
                      password: _password.text.toString());
                  var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(
                      _emailAddress.text.toString());
                  if (methods.contains(_password.text.toString())) {}
                  else {
                    Fluttertoast.showToast(msg: "Registered Successfully");
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
                    'member': DateTime
                        .now()
                        .year
                        .toString(),
                    'updatedDate': DateTime
                        .now()
                        .day
                        .toString() + "/" + DateTime
                        .now()
                        .month
                        .toString() + "/" + DateTime
                        .now()
                        .year
                        .toString()
                  };
                  await FirebaseFirestore.instance.collection('users')
                      .doc(user.user.uid)
                      .set(create);
                  await SharedPrefManager.savePreferenceBoolean(true);
                  await SharedPrefManager.savePrefString(
                      AppConstants.password, _password.text.toString());
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');

                    Fluttertoast.showToast(msg: "Password provided is too weak");
                    setState(() {
                      _isLoad = false;
                    });
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                    setState(() {
                      _isLoad = false;
                    });
                    Fluttertoast.showToast(msg: "User already exist");
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
      onTap: (){
        _trySubmit();
      },
      child: CustomButton(
          text1: Strings.signup, text2: "", width: Get.width, height: 60),
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
            style: const TextStyle(
                color: ColorResources.profilehintColor,
                fontSize: 18,
                letterSpacing: 0.5,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600
            ),
            decoration: const InputDecoration(
              hintText: Strings.first_name,
              hintStyle: TextStyle(
                  color: ColorResources.profilehintColor,
                  fontSize: 18,
                  letterSpacing: 0.5,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600
              ),
              errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter your first name";
              }
              return null;
            },
          ),
        ),
      );
    }

    _middlenameField() {
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
        child: TextFormField(
          controller: _middleName,
          textAlign: TextAlign.start,
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlignVertical: TextAlignVertical.bottom,
          style: const TextStyle(
              color: ColorResources.profilehintColor,
              fontSize: 18,
              letterSpacing: 0.5,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w600
          ),
          decoration: const InputDecoration(
            hintText: Strings.middle_name,
            hintStyle: TextStyle(
                color: ColorResources.profilehintColor,
                fontSize: 18,
                letterSpacing: 0.5,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600
            ),
            errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return "Please enter your Middle name";
            }
            return null;
          },
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
            style: const TextStyle(
                color: ColorResources.profilehintColor,
                fontSize: 18,
                letterSpacing: 0.5,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600
            ),
            decoration: const InputDecoration(
              hintText: Strings.last_name,
              hintStyle: TextStyle(
                  color: ColorResources.profilehintColor,
                  fontSize: 18,
                  letterSpacing: 0.5,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600
              ),
              errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter your last name";
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
            style: const TextStyle(
                color: ColorResources.profilehintColor,
                fontSize: 18,
                letterSpacing: 0.5,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600
            ),
            decoration: const InputDecoration(
              hintText: Strings.email_address,
              hintStyle: TextStyle(
                  color: ColorResources.profilehintColor,
                  fontSize: 18,
                  letterSpacing: 0.5,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600
              ),
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
            style: const TextStyle(
                color: ColorResources.profilehintColor,
                fontSize: 18,
                letterSpacing: 0.5,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600
            ),
            decoration: const InputDecoration(
              hintText: Strings.passwords,
              hintStyle: TextStyle(
                  color: ColorResources.profilehintColor,
                  fontSize: 18,
                  letterSpacing: 0.5,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600
              ),
              errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter your password";
              } else if (value.length < 10) {
                return "Password have must be atleast 10 digits";
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
            style: const TextStyle(
                color: ColorResources.profilehintColor,
                fontSize: 18,
                letterSpacing: 0.5,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600
            ),
            decoration: const InputDecoration(
              hintText: Strings.user_name,
              hintStyle: TextStyle(
                  color: ColorResources.profilehintColor,
                  fontSize: 18,
                  letterSpacing: 0.5,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600
              ),
              errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter your user name";
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
            style: const TextStyle(
                color: ColorResources.profilehintColor,
                fontSize: 18,
                letterSpacing: 0.5,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600
            ),
            decoration: const InputDecoration(
              hintText: Strings.address,
              hintStyle: TextStyle(
                  color: ColorResources.profilehintColor,
                  fontSize: 18,
                  letterSpacing: 0.5,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600
              ),
              errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter your address";
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
            style: const TextStyle(
                color: ColorResources.profilehintColor,
                fontSize: 18,
                letterSpacing: 0.5,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600
            ),
            decoration: const InputDecoration(
              hintText: Strings.city,
              hintStyle: TextStyle(
                  color: ColorResources.profilehintColor,
                  fontSize: 18,
                  letterSpacing: 0.5,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600
              ),
              errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter your city";
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
            style: const TextStyle(
                color: ColorResources.profilehintColor,
                fontSize: 18,
                letterSpacing: 0.5,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600
            ),
            decoration: const InputDecoration(
              hintText: Strings.zipCode,
              hintStyle: TextStyle(
                  color: ColorResources.profilehintColor,
                  fontSize: 18,
                  letterSpacing: 0.5,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600
              ),
              errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter your zip code";
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
                    Image.asset(Images.commonlogo,
                      width: Get.width,
                      height: 94,
                    ),
                    Image.asset(Images.Sisterhood,
                      width: Get.width,
                      height: 70,
                    ),
                    // SizedBox(height: 70),

                    const SizedBox(height: 30),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(Strings.first_name,
                            style: TextStyle(
                              color: ColorResources.profilePlaceholderColor,
                              fontSize: 16,
                              // letterSpacing: 1,
                              // fontFamily: 'Arial',
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(height: 5,),
                        _firstnameField(),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(Strings.last_name,
                            style: TextStyle(
                              color: ColorResources.profilePlaceholderColor,
                              fontSize: 16,
                              // letterSpacing: 1,
                              // fontFamily: 'Arial',
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(height: 5,),
                        _lastnameField(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(Strings.user_name,
                                  style: TextStyle(
                                    color: ColorResources.profilePlaceholderColor,
                                    fontSize: 16,
                                    // letterSpacing: 1,
                                    // fontFamily: 'Arial',
                                    fontWeight: FontWeight.w600,
                                  )),
                              const SizedBox(height: 5,),
                              _usernameField(),
                            ],
                          ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(Strings.email,
                            style: TextStyle(
                              color: ColorResources.profilePlaceholderColor,
                              fontSize: 16,
                              // letterSpacing: 1,
                              // fontFamily: 'Arial',
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(height: 5,),
                        _emailaddressField(),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Password",
                            style: TextStyle(
                              color: ColorResources.profilePlaceholderColor,
                              fontSize: 16,
                              // letterSpacing: 1,
                              // fontFamily: 'Arial',
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(height: 5,),
                        _passwordField(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(Strings.address,
                            style: TextStyle(
                              color: ColorResources.profilePlaceholderColor,
                              fontSize: 16,
                              // letterSpacing: 1,
                              // fontFamily: 'Arial',
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(height: 5,),
                        _phoneNumberField(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(Strings.city,
                            style: TextStyle(
                              color: ColorResources.profilePlaceholderColor,
                              fontSize: 16,
                              // letterSpacing: 1,
                              // fontFamily: 'Arial',
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(height: 5,),
                        _cityField(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(Strings.zipCode,
                            style: TextStyle(
                              color: ColorResources.grey,
                              fontSize: 16,
                              // letterSpacing: 1,
                              // fontFamily: 'Arial',
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(height: 5,),
                        _zipcodeField(),
                      ],
                    ),
                    const SizedBox(height: 30),

                    if(_isLoad)
                      const Center(child: CircularProgressIndicator())
                    else
                      _continuebutton(),

                    // const SizedBox(height: 30,),

                    Container(
                      alignment: Alignment.center,
                      child: FlatButton(onPressed: (){
                        Get.back();
                        /*Get.to(const LoginPage(),
                            transition: Transition.rightToLeftWithFade,
                            duration: const Duration(milliseconds: 600));*/
                      },
                          child: const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'Already Account? ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal
                                )),

                                TextSpan(text: ' Login',
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 15)),
                              ],
                            ),
                          )),
                    ),

                  ]),
            ),
          )
      )
    );
  }
}