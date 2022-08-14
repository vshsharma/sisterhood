import 'package:flutter/material.dart';
import 'package:sisterhood_app/utill/strings.dart';

class AddMediaView extends StatefulWidget {
  final Function onPress;
  final IconData icon;
  final String label;
  const AddMediaView(
      {Key key,
      this.onPress,
      this.icon = Icons.image,
      this.label = Strings.add_picture})
      : super(key: key);

  @override
  State<AddMediaView> createState() => _AddMediaViewState();
}

class _AddMediaViewState extends State<AddMediaView> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPress,
      child: Column(
        children: <Widget>[Icon(widget.icon), Text(widget.label)],
      ),
    );
  }
}
