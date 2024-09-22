import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:webview_win_floating/webview_win_floating.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class GPWebView extends StatefulWidget {
  final String url;

  const GPWebView({super.key, required this.url});

  @override
  State<GPWebView> createState() => _GPWebViewState();
}

class _GPWebViewState extends State<GPWebView> {
  late WebViewController controller;
  late Size size;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));

    return WebViewWidget(controller: controller);
  }
}
