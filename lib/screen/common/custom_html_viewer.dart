import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:html/dom.dart' as dom;

import '../../utill/styles.dart';

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
      defaultTextStyle: courierFont20W600,
      customRender: (node, children) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "li":
              return Column(children: children);
          }
        }
        return null;
      },
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

  Wrap customListItem(dom.Element node) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 2,
          ),
        ),
        Text(node.text)
      ],
    );
  }
}
