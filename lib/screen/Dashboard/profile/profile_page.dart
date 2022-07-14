import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/screen/Dashboard/Home/resources_page.dart';
import 'package:sisterhood_app/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:sisterhood_app/screen/Dashboard/drawer_page.dart';
import 'package:sisterhood_app/screen/Dashboard/profile/resetPassword.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/custom_button.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/strings.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.background,
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorResources.background,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5.0,top: 10),
            child: Column(
              children: [
                InkWell(
                    onTap: _openDrawer,
                    child: const Icon(Icons.list,color: ColorResources.grey,size: 35,)),
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
        drawer: const Drawer(
          child:  DrawerPage(),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('users').doc(_auth.currentUser.uid).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.hasData){
                    return SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Column(
                              children:  [
                                Center(
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ColorResources.box_border,
                                          width: 2,
                                        ),
                                        color: ColorResources.box_background,
                                        borderRadius: BorderRadius.circular(100),
                                        image: DecorationImage(
                                          image:  NetworkImage(snapshot.data['image_url'].toString()),
                                          fit: BoxFit.fill,
                                        )

                                    ),
                                    // child: const Padding(
                                    //   padding: EdgeInsets.all(10.0),
                                    //   child: Image.asset(Images.profileImage),
                                    // ),
                                    // child: CircleAvatar(
                                    //   radius: 50,
                                    //   backgroundColor: ColorResources.box_background,
                                    //   // backgroundImage: NetworkImage(getProfileModel[0].data.customerImage),
                                    // ),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                 Center(
                                  child: Text(snapshot.data['firstname'].toString(),
                                      style: const TextStyle(
                                        color: ColorResources.profileemailColor,
                                        fontSize: 25,
                                        letterSpacing: 1,
                                        // fontFamily: 'Arial',
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                const SizedBox(height: 10,),
                                 Center(
                                  child: Text(snapshot.data['username'].toString(),
                                      style: const TextStyle(
                                        color: ColorResources.profileemailColor,
                                        fontSize: 18,
                                        // letterSpacing: 1,
                                        // fontFamily: 'Arial',
                                        fontWeight: FontWeight.w600,
                                      )),
                                )
                              ],
                            ),
                            const SizedBox(height: 30),
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
                                Container(
                                    decoration: BoxDecoration(
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey.withOpacity(0.4),
                                      //     spreadRadius: 1,
                                      //     blurRadius: 3,
                                      //     offset: Offset(0, 3),
                                      //   ),
                                      // ],
                                      border: Border.all(
                                        color: ColorResources.box_border,
                                        width: 1,
                                      ),
                                      color: ColorResources.background,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 60,
                                    width: Get.width,
                                    alignment: Alignment.centerLeft,
                                    child:  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(snapshot.data['firstname'].toString(),
                                          style: const TextStyle(
                                            color: ColorResources.profilehintColor,
                                            fontSize: 18,
                                            letterSpacing: 0.5,
                                            // fontFamily: 'Arial',
                                            fontWeight: FontWeight.w600,
                                          )),
                                    )),
                              ],
                            ),

                            const SizedBox(height: 20),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(Strings.phoneNumbar,
                                    style: TextStyle(
                                      color: ColorResources.profilePlaceholderColor,
                                      fontSize: 16,
                                      // letterSpacing: 1,
                                      // fontFamily: 'Arial',
                                      fontWeight: FontWeight.w600,
                                    )),

                                const SizedBox(height: 5,),

                                Container(
                                    decoration: BoxDecoration(
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey.withOpacity(0.4),
                                      //     spreadRadius: 1,
                                      //     blurRadius: 3,
                                      //     offset: Offset(0, 3),
                                      //   ),
                                      // ],
                                      border: Border.all(
                                        color: ColorResources.box_border,
                                        width: 1,
                                      ),
                                      color: ColorResources.background,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 60,
                                    width: Get.width,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(snapshot.data['mobile'].toString()==""?"":snapshot.data['mobile'].toString(),
                                          style: const TextStyle(
                                            color: ColorResources.profilehintColor,
                                            fontSize: 18,
                                            letterSpacing: 0.5,
                                            // fontFamily: 'Arial',
                                            fontWeight: FontWeight.w600,
                                          )),
                                    )),
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
                                Container(
                                    decoration: BoxDecoration(
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey.withOpacity(0.4),
                                      //     spreadRadius: 1,
                                      //     blurRadius: 3,
                                      //     offset: Offset(0, 3),
                                      //   ),
                                      // ],
                                      border: Border.all(
                                        color: ColorResources.box_border,
                                        width: 1,
                                      ),
                                      color: ColorResources.background,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 60,
                                    width: Get.width,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(snapshot.data['address'].toString(),
                                          style: const TextStyle(
                                            color: ColorResources.profilehintColor,
                                            fontSize: 18,
                                            letterSpacing: 0.5,
                                            // fontFamily: 'Arial',
                                            fontWeight: FontWeight.w600,
                                          )),
                                    )),
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
                                Container(
                                    decoration: BoxDecoration(
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey.withOpacity(0.4),
                                      //     spreadRadius: 1,
                                      //     blurRadius: 3,
                                      //     offset: Offset(0, 3),
                                      //   ),
                                      // ],
                                      border: Border.all(
                                        color: ColorResources.box_border,
                                        width: 1,
                                      ),
                                      color: ColorResources.background,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 60,
                                    width: Get.width,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(snapshot.data['city'].toString(),
                                          style: const TextStyle(
                                            color: ColorResources.profilehintColor,
                                            fontSize: 18,
                                            letterSpacing: 0.5,
                                            // fontFamily: 'Arial',
                                            fontWeight: FontWeight.w600,
                                          )),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(Strings.zipCode,
                                    style: TextStyle(
                                      color: ColorResources.profilePlaceholderColor,
                                      fontSize: 16,
                                      // letterSpacing: 1,
                                      // fontFamily: 'Arial',
                                      fontWeight: FontWeight.w600,
                                    )),
                                const SizedBox(height: 5,),
                                Container(
                                    decoration: BoxDecoration(
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey.withOpacity(0.4),
                                      //     spreadRadius: 1,
                                      //     blurRadius: 3,
                                      //     offset: Offset(0, 3),
                                      //   ),
                                      // ],
                                      border: Border.all(
                                        color: ColorResources.box_border,
                                        width: 1,
                                      ),
                                      color: ColorResources.background,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 60,
                                    width: Get.width,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(snapshot.data['zipcode'].toString(),
                                          style: const TextStyle(
                                            color: ColorResources.profilehintColor,
                                            fontSize: 18,
                                            letterSpacing: 0.5,
                                            // fontFamily: 'Arial',
                                            fontWeight: FontWeight.w600,
                                          )),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 30),
                            _continuebutton(snapshot.data),
                            const SizedBox(height: 20,),
                            InkWell(
                              onTap:(){
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => ResetPassword()));

                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.white.withOpacity(0.4),
                                    //     spreadRadius: 1,
                                    //     blurRadius: 3,
                                    //     offset: Offset(0, 3),
                                    //   ),
                                    // ],
                                    // border: Border.all(
                                    //   color: Colors.grey,
                                    //   width: 1,
                                    // ),
                                    color: ColorResources.box_background,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 60,
                                  width: Get.width,
                                  alignment: Alignment.centerLeft,
                                  child:  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.lock,size: 20,),
                                        SizedBox(width: 10,),
                                        Text(Strings.resetPassword,
                                            style: TextStyle(
                                              color: ColorResources.profilePlaceholderColor,
                                              fontSize: 16,
                                              // letterSpacing: 0.5,
                                              // fontFamily: 'Arial',
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ],
                                    ),
                                  )),
                            ),
                            const SizedBox(height: 30,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Strings.member_since+ snapshot.data['member'].toString(),
                                    style: const TextStyle(
                                      color: ColorResources.profilePlaceholderColor,
                                      fontSize: 16,
                                      // letterSpacing: 0.5,
                                      // fontFamily: 'Arial',
                                      fontWeight: FontWeight.w600,
                                    )),
                                const SizedBox(height: 20,),
                                Text(Strings.lastmodifieddate+snapshot.data['updatedDate'].toString(),
                                    style: const TextStyle(
                                      color: ColorResources.profilePlaceholderColor,
                                      fontSize: 16,
                                      // letterSpacing: 0.5,
                                      // fontFamily: 'Arial',
                                      fontWeight: FontWeight.w600,
                                    )),
                              ],
                            ),
                            const SizedBox(height: 30,),

                          ]),
                    );
                  }else{
                    return const Text('');
                  }
                },

                )
            )
        ),
        // bottomNavigationBar: BottomNavigationPage(),
    );
  }

  _continuebutton(var profileData) {
    return GestureDetector(
      onTap:(){
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (c) => EditProfilePage(profileData:profileData)));
      },
      child: CustomButton(
          text1: Strings.edit_profile, text2: "", width: Get.width, height: 60),
    );
  }
}