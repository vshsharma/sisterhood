import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utill/color_resources.dart';
import '../../utill/dimension.dart';

class CommonCard extends StatelessWidget {
  final Widget widget;
  const CommonCard(
    this.widget, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorResources.box_background,
            borderRadius: BorderRadius.circular(dim_40),
          ),
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(dim_10),
            child: widget,
          ),
        ),
        const SizedBox(height: dim_15),
      ],
    );
  }
}
