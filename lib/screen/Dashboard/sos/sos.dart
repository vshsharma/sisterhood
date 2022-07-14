import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:sisterhood_app/screen/Dashboard/drawer_page.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:url_launcher/url_launcher.dart';
class SOSPage extends StatefulWidget {
  const SOSPage({Key key}) : super(key: key);
  @override
  _SOSPageState createState() => _SOSPageState();
}

class _SOSPageState extends State<SOSPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }


  _launchURLApp() async {
    const url = 'https://www.sosalarm.se/spraklanguages/english/sms112-english/';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  //  _callNowApp(String phoneNumber) async {
  //   final Uri launchUri = Uri(
  //     scheme: 'tel',
  //     path: phoneNumber,
  //   );
  //   await launch(launchUri.toString());
  // }


  @override
  void initState() {
    super.initState();
    // _callNowApp("112");
    print("iodiap");
  }

  @override
  void dispose() {
    super.dispose();
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
                  child: Icon(Icons.list,color: ColorResources.grey,size: 35,)),
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
      drawer: Drawer(
        child:  DrawerPage(),
      ),

      // bottomNavigationBar: BottomNavigationPage(),
    );
  }
}



