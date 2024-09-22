import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gptwidget/services/service_widget_controller.dart';
import 'package:gptwidget/windows/widget_settings.dart';
import 'package:gptwidget/windows/widget_webview.dart';
import 'package:gptwidget/windows/widget_win_webview.dart';
// import 'package:webview_flutter/webview_flutter.dart';

/// The window is supposed to have expand collaps functionality
/// This is responsible to set the size boundaries to the child views.

class WidgetWindow extends StatefulWidget {
  const WidgetWindow({super.key});

  @override
  State<WidgetWindow> createState() => _WidgetWindowState();
}

class _WidgetWindowState extends State<WidgetWindow> {
  late final ServiceWidgetController controller;

  @override
  void initState() {
    controller = ServiceWidgetController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if(!Platform.isWindows)
            Expanded(
              child: ListenableBuilder(
                listenable: controller,
                builder: (context, val) {
                  return GPWebView(url: controller.selectedAgentUrl);
                },
              ),
            ),
          if(Platform.isWindows)
            Expanded(child: WindowsWebViewImpl(
              controller: controller
            )),
          GPSettingsView(
            controller: controller,
          )
        ],
      ),
    );
  }
}
