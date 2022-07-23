import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utill/color_resources.dart';
import '../../utill/dimension.dart';
import '../../utill/images.dart';
import '../../utill/styles.dart';

class ResourceButton extends StatefulWidget {
  final Function onButtonPress;
  final String labelButton;
  const ResourceButton({this.onButtonPress, this.labelButton, Key key})
      : super(key: key);

  @override
  _ResourceButtonState createState() => _ResourceButtonState();
}

class _ResourceButtonState extends State<ResourceButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.onButtonPress,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorResources.box_border,
                width: 1.5,
              ),
              color: ColorResources.box_background,
              borderRadius: BorderRadius.circular(dim_15),
            ),
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: dim_20, horizontal: dim_20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.labelButton,
                      maxLines: 4,
                      softWrap: true,
                      style: courierFont18W600,
                    ),
                  ),
                  const SizedBox(
                    width: dim_5,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: ColorResources.grey,
                    size: 35,
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: dim_20,
        )
      ],
    );
  }
}
