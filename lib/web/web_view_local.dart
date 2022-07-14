import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sisterhood_app/screen/common/base_widget.dart';
import 'package:sisterhood_app/utill/dimension.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocalFileWebView extends StatefulWidget {
  final String htmlFilePath;
  const LocalFileWebView({this.htmlFilePath, Key key}) : super(key: key);

  @override
  _LocalFileWebViewState createState() => _LocalFileWebViewState();
}

class _LocalFileWebViewState extends State<LocalFileWebView> {
  WebViewController webViewController;
  loadLocalHTML() async{
    String fileHtmlContents = await rootBundle.loadString(widget.htmlFilePath);
    webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      Padding(
        padding: const EdgeInsets.all(dim_20),
        child: WebView(
          initialUrl: '',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController tmp) {
            webViewController = tmp;
            loadLocalHTML();
          },
          backgroundColor: const Color(0x00000000),
        ),
      ),
    );
  }
}
