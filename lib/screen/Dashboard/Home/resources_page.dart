import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/screen/Dashboard/Home/screen10-1.dart';
import 'package:sisterhood_app/screen/Dashboard/Home/screen10.dart';
import 'package:sisterhood_app/screen/Dashboard/profile/profile_page.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/strings.dart';

class ResourcesPage extends StatefulWidget {
  const ResourcesPage({Key key}) : super(key: key);

  @override
  _ResourcesPageState createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
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
                    child: const Icon(Icons.keyboard_arrow_left_outlined,color: ColorResources.grey,size: 35,),),
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
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(Strings.resources,
                                style: TextStyle(
                                  color: Color(0xff545454),
                                  fontSize: 25,
                                  // letterSpacing: 0.3,
                                  fontFamily: 'Courier',
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          const SizedBox(height: 60),
                          InkWell(
                            onTap: (){
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(builder: (context) => ProfilePage()));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ColorResources.box_border,
                                    width: 1.5,
                                  ),
                                  color: ColorResources.box_background,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 60,
                                width: Get.width,
                                child: const Center(
                                  child: Text(Strings.womens_shelters,
                                      style: TextStyle(
                                        color: ColorResources.boxTextcolor,
                                        fontSize: 18,
                                        // letterSpacing: 1,
                                        fontFamily: 'Courier',
                                        fontWeight: FontWeight.bold,
                                      )),
                                )),
                          ),
                          const SizedBox(height: 25),
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
                                  width: 1.5,
                                ),
                                color: ColorResources.box_background,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 60,
                              width: Get.width,
                              child: const Center(
                                child: Center(
                                  child: Text(Strings.legal_information,
                                      style: TextStyle(
                                        color: ColorResources.boxTextcolor,
                                        fontSize: 18,
                                        // letterSpacing: 1,
                                        fontFamily: 'Courier',
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              )),
                          const SizedBox(height: 25),
                          InkWell(
                            onTap: (){
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(builder: (context) => Screen10Page()));
                            },
                            child: Container(
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
                                    width: 1.5,
                                  ),
                                  color: ColorResources.box_background,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 60,
                                width: Get.width,
                                child: const Center(
                                  child: Center(
                                    child: Text(Strings.what_is_abuse,
                                        style: TextStyle(
                                          color: ColorResources.boxTextcolor,
                                          fontSize: 18,
                                          // letterSpacing: 1,
                                          fontFamily: 'Courier',
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                )),
                          ),
                          const SizedBox(height: 25),
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
                                  width: 1.5,
                                ),
                                color: ColorResources.box_background,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 60,
                              width: Get.width,
                              child: const Center(
                                child: Center(
                                  child: Text(Strings.self_care,
                                      style: TextStyle(
                                        color: ColorResources.boxTextcolor,
                                        fontSize: 18,
                                        // letterSpacing: 1,
                                        fontFamily: 'Courier',
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              )),
                          const SizedBox(height: 25),
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
                                  width: 1.5,
                                ),
                                color: ColorResources.box_background,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 60,
                              width: Get.width,
                              child: const Center(
                                child: Center(
                                  child: Text(Strings.sisterhood_app_tutorial,
                                      style: TextStyle(
                                        color: ColorResources.boxTextcolor,
                                        fontSize: 18,
                                        // letterSpacing: 1,
                                        fontFamily: 'Courier',
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              )),
                        ]),
                  )),
            )));
  }

}
