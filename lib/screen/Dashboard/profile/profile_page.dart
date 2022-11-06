import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/screen/Dashboard/drawer_page.dart';
import 'package:sisterhood_app/screen/Dashboard/profile/resetPassword.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/custom_button.dart';
import 'package:sisterhood_app/utill/extension.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/styles.dart';

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
          padding: const EdgeInsets.only(left: 5.0, top: 10),
          child: Column(
            children: [
              InkWell(
                  onTap: _openDrawer,
                  child: const Icon(
                    Icons.list,
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
      drawer: const Drawer(
        child: DrawerPage(),
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_auth.currentUser.uid)
                    .snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Column(
                              children: [
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data['image_url']
                                              .toString()),
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                      snapshot.data['firstname'].toString(),
                                      style: arialFont25W600profileemailColor),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                      snapshot.data['username'].toString(),
                                      style: arialFont18W600),
                                )
                              ],
                            ),
                            const SizedBox(height: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(context.loc.user_name,
                                    style: arialFont16W600),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    decoration: BoxDecoration(
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                          snapshot.data['firstname'].toString(),
                                          style: arialFont18W600),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(context.loc.phone_number,
                                    style: arialFont16W600),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    decoration: BoxDecoration(
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                          snapshot.data['mobile'].toString() ==
                                                  ""
                                              ? ""
                                              : snapshot.data['mobile']
                                                  .toString(),
                                          style: arialFont18W600),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(context.loc.address,
                                    style: arialFont16W600),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    decoration: BoxDecoration(
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                          snapshot.data['address'].toString(),
                                          style: arialFont18W600),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(context.loc.city, style: arialFont16W600),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    decoration: BoxDecoration(
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                          snapshot.data['city'].toString(),
                                          style: arialFont18W600),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(context.loc.zip_code,
                                    style: arialFont16W600),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    decoration: BoxDecoration(
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                          snapshot.data['zipcode'].toString(),
                                          style: arialFont18W600),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 30),
                            _continuebutton(snapshot.data),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ResetPassword()));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorResources.box_background,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 60,
                                  width: Get.width,
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.lock,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(context.loc.reset_password,
                                            style: arialFont16W600),
                                      ],
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    context.loc.member_since +
                                        snapshot.data['member'].toString(),
                                    style: arialFont16W600),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                    context.loc.last_modified_date +
                                        snapshot.data['updatedDate'].toString(),
                                    style: arialFont16W600),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ]),
                    );
                  } else {
                    return const Text('');
                  }
                },
              ))),
      // bottomNavigationBar: BottomNavigationPage(),
    );
  }

  _continuebutton(var profileData) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => EditProfilePage(profileData: profileData)));
      },
      child: CustomButton(
          text1: context.loc.edit_profile,
          text2: "",
          width: Get.width,
          height: 60),
    );
  }
}
