import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webviewDemo extends StatefulWidget {
  const webviewDemo({Key? key}) : super(key: key);

  @override
  State<webviewDemo> createState() => _webviewDemoState();
}

class _webviewDemoState extends State<webviewDemo> {
  WebViewController? controller;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.swiggy.com'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: controller!)),
    );
  }
}
