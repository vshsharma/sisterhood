import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/sharedprefrence.dart';
import 'package:sisterhood_app/utill/strings.dart';

import '../../utill/styles.dart';
import '../../web/web_view.dart';
import '../firebase.dart';
import '../journal_entry/journal_entry_media.dart';
import '../self_help/privacy.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  var current_index = 3;
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
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              titlePadding: const EdgeInsets.only(top: 20.0),
              backgroundColor: Colors.white,
              title: Strings.areyousureyouwantto_logout,
              titleStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      // onTap:()async{
                      //   await FirebaseAuth.instance.signOut();
                      // },
                      onTap: () {
                        SharedPrefManager.clearPrefs();
                        Get.back();
                        Get.snackbar("Logout", "Successfully");
                      },
                      child: Center(
                        child: Container(
                            height: 45,
                            width: 100,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  ColorResources.box_background,
                                  ColorResources.box_background,
                                ]),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(Strings.yes,
                                    style: TextStyle(
                                      color: ColorResources.black,
                                      fontSize: 16,
                                      fontFamily: 'Courier',
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                    )))),
                      )),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Center(
                        child: Container(
                            height: 45,
                            width: 100,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  ColorResources.green,
                                  ColorResources.darkgreen,
                                ]),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(Strings.no,
                                    style: TextStyle(
                                      color: ColorResources.black,
                                      fontSize: 16,
                                      fontFamily: 'Courier',
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                    )))),
                      )),
                ],
              ),
            );
          },
          title: const Padding(
            padding: EdgeInsets.only(bottom: 3.0),
            child: Text(Strings.logout,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontFamily: 'Arial',
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                )),
          ),
          horizontalTitleGap: 0,
          leading: SizedBox(
            height: 25,
            width: 25,
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
                      left: 20.0, top: 30.0, right: 5.0, bottom: 10.0),
                  child: Row(
                    children: [
                      snapshot.data['image_url'] == null
                          ? Image.asset(
                              Images.profileImage,
                              color: ColorResources.profilehintColor,
                              height: 60,
                              width: 60,
                            )
                          : Center(
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorResources.box_border,
                                      width: 2,
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
                  title: const Text(
                    Strings.about_us,
                    style: TextStyle(
                        fontSize: 16,
                        color: ColorResources.profilehintColor,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Arial"),
                  ),
                  horizontalTitleGap: 0,
                  leading: const SizedBox(
                      height: 20,
                      width: 20,
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
                  title: const Text(
                    Strings.privacy_polocy,
                    style: TextStyle(
                        fontSize: 16,
                        color: ColorResources.profilehintColor,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Arial"),
                  ),
                  horizontalTitleGap: 0,
                  leading: const SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(
                        Icons.privacy_tip_outlined,
                        color: ColorResources.profilehintColor,
                      )),
                ),
                ListTile(
                  onTap: () {
                    navigateToContactUs(context);
                  },
                  title: const Text(
                    Strings.contact_us,
                    style: TextStyle(
                        fontSize: 16,
                        color: ColorResources.profilehintColor,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Arial"),
                  ),
                  horizontalTitleGap: 0,
                  leading: const SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(
                        Icons.headset_outlined,
                        color: ColorResources.profilehintColor,
                      )),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => const JournalEntryMedia()));
                  },
                  title: const Text(
                    Strings.settings,
                    style: TextStyle(
                        fontSize: 16,
                        color: ColorResources.profilehintColor,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Arial"),
                  ),
                  horizontalTitleGap: 0,
                  leading: const SizedBox(
                      height: 20,
                      width: 20,
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
