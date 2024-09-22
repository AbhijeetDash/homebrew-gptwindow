import 'package:flutter/material.dart';
import 'package:gptwidget/services/service_widget_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_win_floating/webview_win_floating.dart';

class WindowsWebViewImpl extends StatefulWidget {
  final ServiceWidgetController controller;
  const WindowsWebViewImpl({super.key, required this.controller});

  @override
  State<WindowsWebViewImpl> createState() => _WindowsWebViewImplState();
}

class _WindowsWebViewImplState extends State<WindowsWebViewImpl> {
  late WinWebViewController winController;
  late Size size;

  @override
  Widget build(BuildContext context) {
    winController = WinWebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    return ListenableBuilder(
        listenable: widget.controller,
        builder: (context, snap) {
          winController
              .loadRequest(Uri.parse(widget.controller.currentAgentUrl));
          return WinWebViewWidget(controller: winController);
        });
  }
}
