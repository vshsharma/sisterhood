import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/dimension.dart';
import 'package:sisterhood_app/utill/extension.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/sharedprefrence.dart';

import '../../utill/styles.dart';
import '../../web/web_view.dart';
import '../firebase.dart';
import '../self_help/privacy.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  var currentIndex = 3;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      bottomNavigationBar: Container(
        color: Colors.red.shade100,
        child: ListTile(
          onTap: () {
            Get.defaultDialog(
              radius: 10,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: dim_30, vertical: dim_20),
              titlePadding: const EdgeInsets.only(top: dim_20),
              backgroundColor: Colors.white,
              title: context.loc.are_you_sure_you_want_to_logout,
              titleStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () {
                        SharedPrefManager.clearPrefs();
                        Get.back();
                        Get.snackbar(
                            context.loc.logout, context.loc.successfully);
                      },
                      child: Center(
                        child: Container(
                          height: dim_45,
                          width: dim_100,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [
                                ColorResources.box_background,
                                ColorResources.box_background,
                              ]),
                              borderRadius: BorderRadius.circular(dim_20)),
                          child: Center(
                            child:
                                Text(context.loc.yes, style: courierFont16W600),
                          ),
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Center(
                        child: Container(
                          height: dim_45,
                          width: dim_100,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [
                                ColorResources.green,
                                ColorResources.darkgreen,
                              ]),
                              borderRadius: BorderRadius.circular(dim_20)),
                          child: Center(
                            child:
                                Text(context.loc.no, style: courierFont16W600),
                          ),
                        ),
                      )),
                ],
              ),
            );
          },
          title: Padding(
            padding: EdgeInsets.only(bottom: dim_3),
            child: Text(
              context.loc.logout,
              style: arialFont18W600.copyWith(color: Colors.red),
            ),
          ),
          horizontalTitleGap: 0,
          leading: SizedBox(
            height: dim_25,
            width: dim_25,
            child: Image.asset(
              Images.loginImage,
              color: Colors.red,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(_auth.currentUser.uid)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: dim_20, top: dim_30, right: dim_5, bottom: dim_10),
                  child: Row(
                    children: [
                      snapshot.data['image_url'] == null
                          ? Image.asset(
                              Images.profileImage,
                              color: ColorResources.profilehintColor,
                              height: dim_60,
                              width: dim_60,
                            )
                          : Center(
                              child: Container(
                                height: dim_60,
                                width: dim_60,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorResources.box_border,
                                      width: dim_2,
                                    ),
                                    color: ColorResources.box_background,
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot
                                          .data['image_url']
                                          .toString()),
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data['firstname'].toString() +
                                  " " +
                                  snapshot.data['lastname'].toString(),
                              style: arialFont18W600,
                            ),
                            // _auth.currentUser.email.toString()
                            Text(
                              _auth.currentUser.email.toString(),
                              style: arialFont16W400,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Text('');
              }
            },
          ),
          Container(
            height: 1,
            color: ColorResources.darkgrey,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>BottomNavigationBarPage(selectIndex:0)));
                  },
                  title: Text(
                    context.loc.about_us,
                    style: arialFont16W700,
                  ),
                  horizontalTitleGap: 0,
                  leading: const SizedBox(
                      height: dim_20,
                      width: dim_20,
                      child: Icon(
                        Icons.person_outlined,
                        color: ColorResources.profilehintColor,
                      )),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Privacy(),
                      ),
                    );
                  },
                  title: Text(
                    context.loc.privacy_policy,
                    style: arialFont16W700,
                  ),
                  horizontalTitleGap: 0,
                  leading: const SizedBox(
                      height: dim_20,
                      width: dim_20,
                      child: Icon(
                        Icons.privacy_tip_outlined,
                        color: ColorResources.profilehintColor,
                      )),
                ),
                ListTile(
                  onTap: () {
                    navigateToContactUs(context);
                  },
                  title: Text(
                    context.loc.contact_us,
                    style: arialFont16W700,
                  ),
                  horizontalTitleGap: 0,
                  leading: const SizedBox(
                      height: dim_20,
                      width: dim_20,
                      child: Icon(
                        Icons.headset_outlined,
                        color: ColorResources.profilehintColor,
                      )),
                ),
                ListTile(
                  onTap: () {
                    // TODO settings
                  },
                  title: Text(
                    context.loc.settings,
                    style: arialFont16W700,
                  ),
                  horizontalTitleGap: 0,
                  leading: const SizedBox(
                      height: dim_20,
                      width: dim_20,
                      child: Icon(
                        Icons.settings,
                        color: ColorResources.profilehintColor,
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void navigateToContactUs(BuildContext context) async {
    String response = await FirebaseRealtimeDataService().getContactUsLink();
    print('Link : $response');
    Navigator.of(context).push(MaterialPageRoute(
        builder: (builder) => CustomWebView(
              url: response,
            )));
  }
}
