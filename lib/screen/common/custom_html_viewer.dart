import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomHTMLViewer extends StatefulWidget {
  final String content;
  const CustomHTMLViewer(this.content, {Key key}) : super(key: key);

  @override
  State<CustomHTMLViewer> createState() => _CustomHTMLViewerState();
}

class _CustomHTMLViewerState extends State<CustomHTMLViewer> {
  @override
  Widget build(BuildContext context) {
    return Html(
      data: widget.content,
      defaultTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400),
      onLinkTap: (url) async {
        if (await canLaunchUrlString(url)) {
          await launchUrlString(
            url,
          );
        } else {
          throw 'Could not launch $url';
        }
      },
    );
  }
}
