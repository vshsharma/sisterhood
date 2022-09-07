import 'package:flutter/material.dart';

import '../../utill/dimension.dart';
import '../../utill/strings.dart';

class CustomSearchView extends StatefulWidget {
  final Function value;
  const CustomSearchView(this.value, {Key key}) : super(key: key);

  @override
  State<CustomSearchView> createState() => _CustomSearchViewState();
}

class _CustomSearchViewState extends State<CustomSearchView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(dim_4),
      child: TextField(
        onChanged: widget.value,
        controller: TextEditingController(),
        decoration: const InputDecoration(
            labelText: Strings.search,
            hintText: Strings.search,
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(dim_20)))),
      ),
    );
  }
}
