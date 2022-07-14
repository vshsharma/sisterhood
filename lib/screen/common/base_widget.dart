import 'dart:io';

import 'package:flutter/material.dart';

import '../../utill/color_resources.dart';
import '../../utill/dimension.dart';
import '../../utill/images.dart';

class BaseWidget extends StatelessWidget {
  final Widget childWidget;
  const BaseWidget(this.childWidget, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorResources.background,
        leading: Padding(
          padding: const EdgeInsets.only(left: dim_5, top: dim_10),
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.keyboard_arrow_left_outlined,
                    color: ColorResources.grey,
                    size: dim_35,
                  )),
            ],
          ),
        ),
        // title: Image.asset(Images.logo,width: 50,),
        actions: [
          InkWell(
            onTap: () => exit(0),
            child: Padding(
              padding: const EdgeInsets.only(right: dim_10),
              child: Image.asset(
                Images.loginImage,
                width: dim_30,
                height: dim_30,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: childWidget,
      ),
    );
  }
}
