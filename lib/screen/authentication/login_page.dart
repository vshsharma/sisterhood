import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:sisterhood_app/utill/app_constants.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/custom_button.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/sharedprefrence.dart';
import 'package:sisterhood_app/utill/strings.dart';
import '../Dashboard/profile/signupscreen.dart';
import 'faceId_page.dart';
import 'forgot_password_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() =>
      _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  final _password = TextEditingController();
  bool rememberMe = false;

  void _onRememberMeChanged(bool newValue) => setState(() {
    rememberMe = newValue;
  });

  bool _isLoad = false;

  bool isEmail(em) {

    var p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }

  void _trySubmit() async{
    if(isEmail(username.text)){
      if(_formKey.currentState.validate()){
        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>const FaceIdPage()));
        setState(() {
          _isLoad = true;
        });

        final list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(username.text.toString());

        if (list.isNotEmpty) {
          try {
            final user = await _auth.signInWithEmailAndPassword(email: username.text.toString(),
                password: _password.text.toString());
            if (user != null) {
              await SharedPrefManager.savePreferenceBoolean(true);
              await SharedPrefManager.savePrefString(AppConstants.password, _password.text.toString());
              Get.offAll(()=> const FaceIdPage());
              // Fluttertoast.showToast(msg: "");
              // Navigator.pushNamed(context, HomeScreen.id);
            }
          } on FirebaseAuthException catch (e) {
            //Here you catch the specific error
            if (e.code == 'wrong-password') {
              //The thing that should happen if the password is incorrect
              //In my case it will the change the hinttext
              setState(() {
                // print('Password incorrect. Please try again');
                Fluttertoast.showToast(msg: "Please enter valid password");
                // passwordHintColor = Colors.red;
              });
            } else if (e.code == 'user-not-found') {
              setState(() {
                print('No user found for that email.');
                // emailHintColor = Colors.red;
              });
            }
          } catch (e) {
            print(e);
          }

          // print("exis");
          // Return true because there is an existing
          // user using the email address
          // return true;
        } else {
          Fluttertoast.showToast(msg: "User credential are invalid");
          // print("not exis");
         /* await _auth.createUserWithEmailAndPassword(email: username.text.toString(), password: _password.text.toString());
          final user = await _auth.signInWithEmailAndPassword(email: username.text.toString(),
              password: _password.text.toString());

          Map<String,dynamic> newcreate = {};
          Map<String,dynamic> create = {
            'username': username.text.toString(),
            'firstname': '',
            'middleName': '',
            'lastname': '',
            'mobile': '',
            'city': '',
            'zipcode': '',
            'image_url':'',
            'member':DateTime.now().year.toString(),
            'updatedDate' : DateTime.now().day.toString()+"/"+DateTime.now().month.toString()+"/"+DateTime.now().year.toString()
          };

          await FirebaseFirestore.instance.collection('users').doc(user.user.uid).set(create);
          await SharedPrefManager.savePreferenceBoolean(true);
          await SharedPrefManager.savePrefString(AppConstants.password, _password.text.toString());
          Get.offAll(()=> const FaceIdPage());*/

          // if (user != null) {
          //   Get.offAll(()=> const FaceIdPage());
          //   // Fluttertoast.showToast(msg: "");
          //   // Navigator.pushNamed(context, HomeScreen.id);
          // }
          // Return false because email adress is not in use
          // return false;
        }
        // AuthRepo authRepo = new AuthRepo();
        // await authRepo.loginWithOtp(_mobile.text);
        setState(() {
          _isLoad = false;
        });}
    }else{
      Fluttertoast.showToast(msg: "Please enter valid email");
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
                    child: Column(
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
                          SizedBox(height: 70),
                          _mobileno(),
                          const SizedBox(height: 20),
                          _passwordField(),
                          const SizedBox(height: 5,),
                          Container(
                            alignment: Alignment.centerRight,
                            child: FlatButton(onPressed: (){
                              Get.to(const ForgotPasswordPage(),
                                  transition: Transition.rightToLeftWithFade,
                                  duration: const Duration(milliseconds: 600));
                            },
                                child: const Text(Strings.forgot_password,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: "Roboto",
                                        letterSpacing: 0.5,
                                        color: ColorResources.grey)
                                )),
                          ),
                          const SizedBox(height: 40),

                          if(_isLoad == true)
                            const SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator())
                          else
                            _continuebutton(),

                          Container(
                            alignment: Alignment.center,
                            child: FlatButton(onPressed: (){
                              Get.to(const SignupScreen(),
                            transition: Transition.rightToLeftWithFade,
                            duration: const Duration(milliseconds: 600));
                            },
                                child: const Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Don't have an Account? ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal
                                          )),

                                      TextSpan(text: ' Signup',
                                          style: TextStyle(fontWeight: FontWeight.bold,
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




  _numberfield() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              height: 55,
              // width: Get.width,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white
                // gradient: LinearGradient(colors: [
                //   Color(0xffe8fcf5),
                //   Color(0xffe8fcf5),
                // ]),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 1),
                child: Row(
                  children: [
                    Container(
                      // height: 55,
                      width: 50,
                      child: Icon(Icons.person),
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLines: 1,
                        // controller: _mobile,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter mobile number";
                          } else if (value.length < 10) {
                            return "Mobile number have must be atleast 10 digits";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: "Mobile Number",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          labelStyle: new TextStyle(
                            fontSize: 13.0,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    // Icon(
                    //   Icons.clear,
                    //   color: Colors.grey,
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30,),
            Container(
              // height: 50,
              // width: Get.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: ColorResources.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
                color: ColorResources.loginColor,
                borderRadius: BorderRadius.circular(10),
              ),
              // decoration: BoxDecoration(boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.4),
              //     spreadRadius: 1,
              //     blurRadius: 3,
              //     offset: Offset(0, 3),
              //   ),
              // ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 1),
                child: Row(
                  children: [
                    const SizedBox(
                      // height: 45,
                      width: 50,
                      child: Icon(Icons.lock),
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLines: 1,
                        controller: _password,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter password";
                          } else if (value.length < 10) {
                            return "Password have must be atleast 10 digits";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          labelStyle: TextStyle(
                            fontSize: 13.0,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    // Icon(
                    //   Icons.clear,
                    //   color: Colors.grey,
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(onPressed: (){
                // Get.to(ForgotPasswordPage(),
                //     transition: Transition.rightToLeftWithFade,
                //     duration: Duration(milliseconds: 600));
              },
                  child: const Text(Strings.forgot_password,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: "Roboto",
                          letterSpacing: 0.5,
                          color: ColorResources.grey)
                  )),
            ),
          ],
        ),
      ),
    );
  }


  _continuebutton() {
    return GestureDetector(
      onTap: (){
        _trySubmit();
      },
      child: CustomButton(
          text1: Strings.login, text2: "", width: Get.width, height: 60),
    );
  }


  _mobileno() {
    return Container(
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 1,
        //     blurRadius: 1,
        //     offset: Offset(0, 3),
        //   ),
        // ],
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
            prefixIcon: Image.asset(Images.smsImage,
            scale: 4.0,
            ),
            hintText: "EMAIL",
            hintStyle: const TextStyle(
                color: ColorResources.grey,
                fontSize: 16,
                letterSpacing: 0.5,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w600
            ),
            errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
            border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        validator: (value) => EmailValidator.validate(value) ? null : "Please enter valid email",
        // validator: (value) {
        //   if (value.trim().isEmpty) {
        //     return "Please, enter your Email Id";
        //   }
        //
        //   return null;
        // },
      ),
    );
  }
  _passwordField() {
    return Container(
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 1,
        //     blurRadius: 1,
        //     offset: Offset(0, 3),
        //   ),
        // ],
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
          prefixIcon: Image.asset(Images.lockImage,
            scale: 4.0,
          ),
            hintText: Strings.password,
            hintStyle: const TextStyle(
                color: ColorResources.grey,
                fontSize: 16,
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
    );
  }

}
