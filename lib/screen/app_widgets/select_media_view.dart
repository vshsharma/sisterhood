import 'package:flutter/material.dart';

import '../../utill/color_resources.dart';
import '../../utill/dimension.dart';

class SelectedMediaWidget extends StatelessWidget {
  final Widget widget;
  const SelectedMediaWidget({Key key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Image Selection Container
      padding: const EdgeInsets.all(dim_8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorResources.box_border,
            width: dim_2,
          ),
          color: ColorResources.box_background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: widget,
      ),
    );
  }
}
