import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/custom_button.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/strings.dart';

import 'otp_page.dart';


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
            padding: const EdgeInsets.only(left: 5.0,top: 10),
            child: Column(
              children: [
                InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.keyboard_arrow_left_outlined,color: ColorResources.grey,size: 35,)),
                // Image.asset(Images.commonlogo,scale: 20,),
                // Image.asset(Images.Sisterhood,scale: 20,),
              ],
            ),
          ),
          // title: Image.asset(Images.logo,width: 50,),
          actions: [
            InkWell(
              onTap:()=> exit(0),
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset(Images.loginImage,width: 30,height: 30,),
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
                      SizedBox(
                        height: 20),
                      _logo(),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
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
                        height: 55,
                        alignment: Alignment.bottomLeft,
                        child: TextFormField(
                          controller: _username,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(

                            prefixIcon: Image.asset(Images.smsImage,
                              scale: 4.0,
                            ),
                            hintText: Strings.email,
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
                            if (value.trim().isEmpty) {
                              return "Please, enter your username";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 80),
                      InkWell(
                        onTap: ()async{
                          if(_username.text.isEmpty){
                            Fluttertoast.showToast(msg: "Please enter email");
                          }else{
                            final list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(_username.text.toString());

                            if (list.isNotEmpty) {
                              await FirebaseAuth.instance.sendPasswordResetEmail(email: _username.text.toString()).then((value){
                                Fluttertoast.showToast(msg: "We have sent link successfully to your registered email");
                              });
                            }else{
                              Fluttertoast.showToast(msg: "User doesn't exist");
                            }
                          }
                          /*Get.to(OtpPage(),
                              transition: Transition.rightToLeftWithFade,
                              duration: const Duration(milliseconds: 600));*/
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: CustomButton(
                              text1: "Get Mail", text2: "", width: Get.width, height: 50),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(height: 2,
                              width: 60,
                              color: Colors.black12),
                          const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.black12,
                            child: Text("Or",style: TextStyle(
                                color: ColorResources.black,
                                fontFamily: "Roboto",
                                fontSize: 12
                            ),),
                          ),
                          Container(height: 2,
                              width: 60,
                              color: Colors.black12),
                        ],
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: (){
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
                                      child: Text("Go to Login",
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
                      SizedBox(height: 40,),
                      // _extratext(),

                    ]),
                  ),
                ),
              )),
        ));
  }

  // _extratext(){
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //       Text(Strings.text1,
  //       textAlign: TextAlign.center,
  //       style: TextStyle(
  //         fontFamily: 'Roboto',
  //         fontSize: Dimensions.text_size15,
  //         fontWeight: FontWeight.w600,
  //         letterSpacing: 0.5,
  //         color: AppColors.titleColor
  //       ),
  //       ),
  //       SizedBox(height: Dimensions.sizebox_size20,),
  //       Text(Strings.text2,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //             fontFamily: 'Roboto',
  //             fontSize: Dimensions.text_size15,
  //             fontWeight: FontWeight.w400,
  //             letterSpacing: 0,
  //             color: Colors.grey
  //         ),
  //       ),
  //       SizedBox(height: Dimensions.sizebox_size20,),
  //       Text(Strings.text3,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //             fontFamily: 'Roboto',
  //             fontSize: Dimensions.text_size15,
  //             fontWeight: FontWeight.w600,
  //             letterSpacing: 0.5,
  //             color: AppColors.titleColor
  //         ),
  //       ),
  //     ],
  //
  //   );
  // }

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
                  image: DecorationImage(
                      image: AssetImage(Images.commonlogo)
                  ))),
        ),
        Container(
            height: 80,
            // width: 180,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.Sisterhood)
                ))),

      ],
    );
  }

}