import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/custom_button.dart';
import 'package:sisterhood_app/utill/extension.dart';
import 'package:sisterhood_app/utill/images.dart';

import 'changepassword.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();

  var pincode;
  bool _isLoad = false;

  // void _trySubmit()async{
  //   if(pincode!=null){
  //     setState(() {
  //       _isLoad = true;
  //     });
  //     AuthRepo authRepo = new AuthRepo();
  //     await authRepo.loginotpVeriryApi(mobileno,pincode);
  //     setState(() {
  //       _isLoad = false;
  //     });
  //   }
  // }

  // void _resendOtp()async{
  //   setState(() {
  //     _isLoad = true;
  //   });
  //   AuthRepo authRepo = new AuthRepo();
  //   authRepo.resendOtpApi(mobileno);
  //   setState(() {
  //     _isLoad = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.background,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                _logo(),
                SizedBox(
                  height: 50,
                ),
                _welcometext(),
                SizedBox(
                  height: 35,
                ),
                _otpfield(),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Get.to(ChangePassword(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomButton(
                        text1: "Submit",
                        text2: "",
                        width: Get.width,
                        height: 50),
                  ),
                ),
                SizedBox(
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
                        "Or",
                        style: TextStyle(
                            color: ColorResources.black,
                            fontFamily: "Roboto",
                            fontSize: 12),
                      ),
                    ),
                    Container(height: 2, width: 60, color: Colors.black12),
                  ],
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>BottomNavigationBarPage()));
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
                              offset: Offset(0, 3),
                            ),
                          ],
                          gradient: LinearGradient(colors: [
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
                                child: Text(context.loc.resend_otp,
                                    style: TextStyle(
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
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
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
              // width: 180,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(Images.commonlogo)))),
        ),
        Container(
            height: 80,
            // width: 180,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(Images.Sisterhood)))),
      ],
    );
  }

  _welcometext() {
    return Text(
      context.loc.otp_text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Courier',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
          color: ColorResources.black),
    );
  }

  _otpfield() {
    return Form(
      child: OTPTextField(
        length: 6,
        width: MediaQuery.of(context).size.width,
        fieldWidth: 40,
        style: TextStyle(fontSize: 16),
        textFieldAlignment: MainAxisAlignment.spaceEvenly,
        fieldStyle: FieldStyle.underline,
        onChanged: (pin) {
          print("Changed: " + pin);
        },
        onCompleted: (pin) {
          pincode = pin;
          print("Completed: " + pin);
          print("pincode" + pincode);
        },
      ),
    );
  }
}
