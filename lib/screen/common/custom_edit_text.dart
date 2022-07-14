import 'package:flutter/material.dart';

import '../../utill/color_resources.dart';
import '../../utill/dimension.dart';
import '../../utill/strings.dart';
import '../../utill/styles.dart';

class CustomEditTextField extends StatelessWidget {
  final controller;
  const CustomEditTextField(this.controller, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorResources.box_borderscreen10,
          width: dim_1,
        ),
        color: ColorResources.background,
        borderRadius: BorderRadius.circular(dim_10),
      ),
      alignment: Alignment.topLeft,
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        maxLines: 2,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlignVertical: TextAlignVertical.bottom,
        style: arialFont14W600,
        decoration: const InputDecoration(
          hintText: Strings.type_your_text_here,
          hintStyle: arialFont14W600,
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "Empty";
          }
          return null;
        },
      ),
    );
  }
}