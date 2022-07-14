import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utill/app_paddings.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimension.dart';

class GreyBackgroundCard extends StatelessWidget {
  final Widget child;
  const GreyBackgroundCard({
    this.child,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorResources.box_background,
        borderRadius: BorderRadius.circular(dim_25),
      ),
      width: Get.width,
      child: Padding(
        padding: cardPadding,
        child: child,
      ),
    );
  }
}