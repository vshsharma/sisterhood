import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:sisterhood_app/location/location_util.dart';
import 'package:sisterhood_app/screen/Dashboard/Home/viewHistory/journal_history_list.dart';
import 'package:sisterhood_app/screen/Dashboard/drawer_page.dart';
import 'package:sisterhood_app/screen/journal_entry/journal_entry_media.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/styles.dart';
import 'package:sisterhood_app/utill/utils.dart';

import '../../resource/resource_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  void initState() {
    super.initState();
    checkGps();
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
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(height: 30),
                    Image.asset(
                      Images.commonlogo,
                      width: Get.width,
                      height: 94,
                    ),
                    Image.asset(
                      Images.Sisterhood,
                      width: Get.width,
                      height: 70,
                    ),
                    const SizedBox(height: 70),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const JournalEntryMedia()));
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
                          child: Center(
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context).new_journal_entry,
                                style: courierFont18W600.copyWith(
                                    color: ColorResources.boxTextcolor),
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const JournalHistoryList()));
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
                          child: Center(
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context).view_history,
                                style: courierFont18W600.copyWith(
                                    color: ColorResources.boxTextcolor),
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ResourcePage()));
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
                          child: Center(
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context).resources,
                                style: courierFont18W600.copyWith(
                                    color: ColorResources.boxTextcolor),
                              ),
                            ),
                          )),
                    ),
                  ]),
                ))));
  }

  Future<void> checkGps() async {
    bool isServiceEnabled = await LocationUtil.isGeoLocationEnabled();
    if (isServiceEnabled) {
      bool isLocationPermission = await LocationUtil.locationPermission();
      Utils.log("LocationPermission: $isLocationPermission");
    }
  }
}
