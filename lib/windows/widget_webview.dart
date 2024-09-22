import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gptwidget/application/application.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart';

// ignore: must_be_immutable
class GPWebView extends StatefulWidget {
  final String url;

  const GPWebView({super.key, required this.url});

  @override
  State<GPWebView> createState() => _GPWebViewState();
}

class _GPWebViewState extends State<GPWebView> {
  late WebViewController controller;

  WebviewController windowsWebController = WebviewController();

  Future<WebviewPermissionDecision> _onPermissionRequested(
      String url, WebviewPermissionKind kind, bool isUserInitiated) async {
    final decision = await showDialog<WebviewPermissionDecision>(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('WebView permission requested'),
        content: Text('WebView has requested permission \'$kind\''),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.deny),
            child: const Text('Deny'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.allow),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    return decision ?? WebviewPermissionDecision.none;
  }

  Future<bool> initialiseWindowsWebView() async {
    await windowsWebController.initialize();

    // Use a different WebView Plugin.
    await windowsWebController.setBackgroundColor(Colors.transparent);
    await windowsWebController.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
    await windowsWebController.setCacheDisabled(true);
    await windowsWebController.loadUrl(widget.url);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows) {
      return FutureBuilder(
        future: initialiseWindowsWebView(),
        builder: (context, value) {
          return Webview(
            windowsWebController,
            permissionRequested: _onPermissionRequested,
          );
        },
      );
    }

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));

    return WebViewWidget(controller: controller);
  }
}
