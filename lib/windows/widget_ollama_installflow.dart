import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gptwidget/services/service_ollama_installflow.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WidgetOllamaInstallflow extends StatefulWidget {
  const WidgetOllamaInstallflow({super.key});

  @override
  State<WidgetOllamaInstallflow> createState() =>
      _WidgetOllamaInstallflowState();
}

class _WidgetOllamaInstallflowState extends State<WidgetOllamaInstallflow> {
  late ServiceOllamaInstallflow installFlowService;

  int currentInstallStep = 0;
  List<Widget> flowStep = [];

  @override
  void initState() {
    installFlowService = ServiceOllamaInstallflowImpl();

    installFlowService.outputStream.listen((data) {
      // These be the echo messages from the script.

      if (data.contains("#")) {
        // get into comparision for which widget to add.

        switch (data) {
          case "#SHOW_INSTALL_BUTTON":
            WebViewController installOllamaController = WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..loadRequest(Uri.parse("https://ollama.com/download"));
            flowStep.addAll([
              SizedBox(
                height: 400.0,
                child: WebViewWidget(controller: installOllamaController),
              ),
              const SizedBox(height: 12.0),
            ]);
            break;
          case "#EXIT_PROCESS":
            Timer(const Duration(seconds: 1), (){
              Navigator.of(context).pop();
            });
            break;
        }

        // Rebuild the UI.
        setState(() {});
        return;
      }

      flowStep.addAll([
        Text(
          data,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 12.0),
      ]);

      // Rebuild the UI
      setState(() {});
    });

    // Start the install Script.
    installFlowService.runBashScript();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            ...flowStep,
            const SizedBox(height: 20.0),
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: const Text("Close", style: TextStyle(color: Colors.white),))
          ],
        ),
      ),
    );
  }
}
