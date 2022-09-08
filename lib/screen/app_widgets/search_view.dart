import 'package:flutter/material.dart';
import 'package:sisterhood_app/utill/color_resources.dart';

import '../../utill/dimension.dart';
import '../../utill/strings.dart';

class CustomSearchView extends StatefulWidget {
  Function value;
  TextEditingController textEditingController;
  CustomSearchView(this.value, this.textEditingController, {Key key})
      : super(key: key);

  @override
  State<CustomSearchView> createState() => _CustomSearchViewState();
}

class _CustomSearchViewState extends State<CustomSearchView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: dim_10, vertical: dim_4),
      child: TextField(
        onChanged: widget.value,
        controller: widget.textEditingController,
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorResources.white,
          contentPadding: const EdgeInsets.all(dim_0),
          isDense: false,
          labelText: Strings.search,
          hintText: Strings.search,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: InkWell(
            child: const Icon(Icons.cancel),
            onTap: () {
              widget.textEditingController.clear();
              widget.value('');
            },
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(dim_40),
            ),
          ),
        ),
      ),
    );
  }
}
