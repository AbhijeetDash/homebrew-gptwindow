import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:window_manager/window_manager.dart';
// import 'package:webview_flutter/webview_flutter.dart';

/// The window is supposed to have expand collaps functionality
/// This is responsible to set the size boundaries to the child views.

class WidgetWindow extends StatefulWidget {
  const WidgetWindow({super.key});

  @override
  State<WidgetWindow> createState() => _WidgetWindowState();
}

class _WidgetWindowState extends State<WidgetWindow> {
  late WebViewController controller;
  String defaultChatAgent = "Chat-GPT";
  String defaultAgentUrl = "https://chatgpt.com/";
  bool isExpanded = false;

  // Close the options window to the left.
  void shrinkWindow() {
    windowManager.setSize(const Size(500, 900));
    isExpanded = !isExpanded;
    setState(() {});
  }

  // Open the options window to the left.
  void expandWindow() {
    windowManager.setSize(const Size(850, 900));
    isExpanded = !isExpanded;
    setState(() {});
  }

  // Setting the current Agent.
  void setCurrentAgent() {
    switch (defaultChatAgent) {
      case "Chat-GPT":
        defaultAgentUrl = "https://chatgpt.com/";
        controller.loadRequest(Uri.parse(defaultAgentUrl));
        break;
      case "Gemini":
        defaultAgentUrl = "https://gemini.google.com/app?hl=en-IN";
        controller.loadRequest(Uri.parse(defaultAgentUrl));
        break;
    }
  }

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(defaultAgentUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 450,
            child: WebViewWidget(controller: controller),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (isExpanded) {
                          shrinkWindow();
                          return;
                        }

                        expandWindow();
                        return;
                      },
                      icon: const Icon(Icons.settings),
                    ),
                    if (isExpanded) ...[
                      const Text(
                        "Settings",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ]
                  ],
                ),
                if (isExpanded)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20.0),
                        // const Text(
                        //   "Hotkey Settings",
                        //   style: TextStyle(color: Colors.white, fontSize: 18),
                        // ),
                        // const SizedBox(height: 12.0),
                        // Container(
                        //   height: 60,
                        //   width: double.maxFinite,
                        //   color: Colors.grey[850],
                        //   alignment: Alignment.centerLeft,
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 8.0, vertical: 8.0),
                        //   child: Row(
                        //     children: [
                        //       Text(
                        //         "CTRL + SPACE",
                        //         style: TextStyle(
                        //             color: Colors.white.withOpacity(0.3),
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.w500),
                        //       ),
                        //       const Spacer(),
                        //       InkWell(
                        //         onTap: () {
                        //           // Handle the record functionality.
                        //         },
                        //         child: Container(
                        //           color: Colors.greenAccent,
                        //           padding: const EdgeInsets.symmetric(
                        //               horizontal: 12.0, vertical: 12.0),
                        //           child: const Text("Record"),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(height: 8.0),
                        // const Text(
                        //   "Hit ⏎ to save",
                        //   style: TextStyle(color: Colors.white),
                        // ),
                        // const SizedBox(height: 20.0),
                        const Text(
                          "Assistant Settings",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(height: 12.0),
                        Container(
                          height: 60,
                          width: double.maxFinite,
                          color: Colors.grey[850],
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: DropdownButton<String>(
                            menuWidth: 320,
                            underline: const SizedBox(),
                            dropdownColor: Colors.grey[900],
                            icon: const Padding(
                              padding: EdgeInsets.only(left: 250),
                              child: Icon(Icons.arrow_drop_down),
                            ),
                            value: defaultChatAgent,
                            items: const [
                              DropdownMenuItem(
                                value: "Chat-GPT",
                                child: Text(
                                  "Chat-GPT",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "Gemini",
                                child: Text(
                                  "Gemini",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                            onChanged: (val) {
                              defaultChatAgent = val ?? defaultChatAgent;
                              setCurrentAgent();
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          "Hit ⏎ to save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
