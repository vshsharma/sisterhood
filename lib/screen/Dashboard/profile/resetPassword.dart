import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/screen/Dashboard/profile/profile_page.dart';
import 'package:sisterhood_app/utill/app_constants.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/custom_button.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/sharedprefrence.dart';
import 'package:sisterhood_app/utill/strings.dart';

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

   Future<void> _changePassword(String password) async{
     //Create an instance of the current user.

     FirebaseAuth user = await FirebaseAuth.instance;
     // user.currentUser.
     //Pass in the password to updatePassword.
     // user.sendPasswordResetEmail(email: "moh");
     user.currentUser.updatePassword(password).then((_){
       Fluttertoast.showToast(msg: "Your password had been updated successfully");
       Navigator.pop(context);
     }).catchError((error){
       print("Password can't be changed" + error.toString());
       //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
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
             padding: const EdgeInsets.only(left: 5.0,top: 10),
             child: Column(
               children: [
                 InkWell(
                     onTap: (){
                       Navigator.of(context).pop();
                     },
                     child: const Icon(Icons.keyboard_arrow_left_outlined,color: ColorResources.grey,size: 35,)),
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
             child: Center(
               child: Padding(
                   padding: EdgeInsets.all(20.0),
                   child: SingleChildScrollView(
                     child: Form(
                       key: _formKey,
                       child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Text(Strings.resetPassword,
                               style: TextStyle(
                                   color: ColorResources.profilehintColor,
                                   fontSize: 20,
                                   letterSpacing: 0.5,
                                   fontFamily: 'Arial',
                                   fontWeight: FontWeight.w600
                               ),
                             ),
                             SizedBox(height: 30),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [

                                 Text(Strings.oldPassword,
                                     style: TextStyle(
                                       color: ColorResources.profilePlaceholderColor,
                                       fontSize: 16,
                                       // letterSpacing: 1,
                                       // fontFamily: 'Arial',
                                       fontWeight: FontWeight.w600,
                                     )),
                                 SizedBox(height: 5,),
                                 _oldPasswordField(),
                               ],
                             ),
                             SizedBox(height: 20),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 const Text(Strings.newPassword,
                                     style: TextStyle(
                                       color: ColorResources.profilePlaceholderColor,
                                       fontSize: 16,
                                       // letterSpacing: 1,
                                       // fontFamily: 'Arial',
                                       fontWeight: FontWeight.w600,
                                     )),
                                 SizedBox(height: 5,),
                                 _newPasswordField(),
                               ],
                             ),
                             SizedBox(height: 20),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 const Text(Strings.confirmPassword,
                                     style: TextStyle(
                                       color: ColorResources.profilePlaceholderColor,
                                       fontSize: 16,
                                       // letterSpacing: 1,
                                       // fontFamily: 'Arial',
                                       fontWeight: FontWeight.w600,
                                     )),
                                 SizedBox(height: 5,),
                                 _confirmPasswordField(),
                               ],
                             ),
                             SizedBox(height: 120),
                             if(isLoad == true)
                               Center(child: CircularProgressIndicator())
                             else
                             _continuebutton(),
                             SizedBox(height: 30,),

                           ]),
                     ),
                   )
               ),
             )
         )
     );
   }


   _continuebutton() {
     return GestureDetector(
       onTap: ()async{
         if(_oldpassword.text.isEmpty){
           Fluttertoast.showToast(msg: "Please enter old password");
         }else if(_newpassword.text.isEmpty){
           Fluttertoast.showToast(msg: "Please enter new password");
         }else if(_newpassword.text.length<8){
           Fluttertoast.showToast(msg: "Please enter at least up to 8 character new password");
         }else if(_confirmpassword.text.toString() != _newpassword.text.toString()){
           Fluttertoast.showToast(msg: "Please enter same as new password");
         }else{
           /*final user = await FirebaseAuth.instance.currentUser;
           final cred = EmailAuthProvider.credential(
               email: user.email, password: user.pa);*/
           var password = await SharedPrefManager.getPrefrenceString(AppConstants.password);
           if( password.toString() == _oldpassword.text.toString()){
             setState(() {
               isLoad = true;
             });
             await _changePassword(_newpassword.text.toString());

             setState(() {
               isLoad = false;
             });
           }else{
             Fluttertoast.showToast(msg: "Old password doesn't match");
           }
         }
         // Get.to(EditProfilePage(),
         // transition: Transition.rightToLeftWithFade,
         //   duration: Duration(milliseconds: 600)
         // );
       },
       child: CustomButton(
           text1: Strings.save, text2: "", width: Get.width, height: 60),
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
               style: TextStyle(
                   color: ColorResources.profilehintColor,
                   fontSize: 18,
                   letterSpacing: 0.5,
                   fontFamily: 'Arial',
                   fontWeight: FontWeight.w600
               ),
               decoration: InputDecoration(
                 hintText: Strings.oldPassword,
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
               obscureText: _obscureText,
               validator: (value) {
                 if (value.isEmpty) {
                   return "Please enter your old password";
                 }
                 return null;
               },
             ),
           ),
           InkWell(
             onTap: _toggle,
             child: Padding(
               padding: const EdgeInsets.only(right: 15.0),
               child: Image.asset(Images.eyeImage,color: _obscureText?ColorResources.black:Colors.red,scale: 4,),
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
               style: TextStyle(
                   color: ColorResources.profilehintColor,
                   fontSize: 18,
                   letterSpacing: 0.5,
                   fontFamily: 'Arial',
                   fontWeight: FontWeight.w600
               ),
               decoration: InputDecoration(
                 hintText: Strings.newPassword,
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
               obscureText: _obscureText1,
               validator: (value) {
                 if (value.trim().isEmpty) {
                   return "Please, enter the new password";
                 }
                 if (value.trim().length < 10) {
                   return "Password should be more then 10 characters";
                 }
                 return null;
               },
             ),
           ),
           InkWell(
             onTap: _toggle1,
             child: Padding(
               padding: const EdgeInsets.only(right: 15.0),
               child: Image.asset(Images.eyeImage,color: _obscureText1?ColorResources.black:Colors.red,scale: 4,),
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
               style: TextStyle(
                   color: ColorResources.profilehintColor,
                   fontSize: 18,
                   letterSpacing: 0.5,
                   fontFamily: 'Arial',
                   fontWeight: FontWeight.w600
               ),
               decoration: InputDecoration(
                 hintText: Strings.confirmPassword,
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
               obscureText: _obscureText2,
               validator: (value) {
                 if (value.trim().isEmpty) {
                   return "Please, enter the confirm password";
                 }
                 if (value!=_newpassword.text) {
                   return "Confirm password not match";
                 }
                 return null;
               },
             ),
           ),
           InkWell(
             onTap: _toggle2,
             child: Padding(
               padding: const EdgeInsets.only(right: 15.0),
               child: Image.asset(Images.eyeImage,color: _obscureText2?ColorResources.black:Colors.red,scale: 4,),
             ),
           )
         ],
       ),
     );
   }

 }
