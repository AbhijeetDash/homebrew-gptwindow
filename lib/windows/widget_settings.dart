import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gptwidget/services/service_widget_controller.dart';
import 'package:window_manager/window_manager.dart';

class GPSettingsView extends StatefulWidget {
  final ServiceWidgetController controller;
  const GPSettingsView({super.key, required this.controller});

  @override
  State<GPSettingsView> createState() => _GPSettingsViewState();
}

class _GPSettingsViewState extends State<GPSettingsView> {
  bool isExpanded = false;

  // Close the options window to the left.
  void shrinkWindow() {
    // get the current width
    double width = MediaQuery.of(context).size.width;

    windowManager.setSize(Size(width-300, 900));
    isExpanded = !isExpanded;
    setState(() {});
  }

  // Open the options window to the left.
  void expandWindow() {
     // get the current width
    double width = MediaQuery.of(context).size.width;
    windowManager.setSize(Size(width+300, 900));
    isExpanded = !isExpanded;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isExpanded? 300 : 50,
      constraints: const BoxConstraints(maxWidth: 300, minWidth: 50),
      color: widget.controller.currentAgentValue == "Chat-GPT"
          ? const Color.fromARGB(255, 16, 16, 16)
          : Colors.grey[900],
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
                      icon: const Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                      value: widget.controller.currentAgentValue,
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
                        ),
                        DropdownMenuItem(
                          value: "Olm3.1-4B",
                          child: Text(
                            "Ollama 3.1 4B",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                      onChanged: (val) {
                        widget.controller
                            .changeSelectedAgent(val ?? "Chat-GPT");
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    "Hit ⏎ to save",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Window Settings",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 12.0),
                  Container(
                    height: 60,
                    width: double.maxFinite,
                    color: Colors.grey[850],
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 8.0, bottom: 12.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.grey[500],
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(border: InputBorder.none),
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
    );
  }
}
