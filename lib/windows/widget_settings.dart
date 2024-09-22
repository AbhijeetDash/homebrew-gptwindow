import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gptwidget/services/service_prefs.dart';
import 'package:gptwidget/services/service_widget_controller.dart';
import 'package:gptwidget/windows/widget_ollama_installflow.dart';
import 'package:window_manager/window_manager.dart';

class GPSettingsView extends StatefulWidget {
  final ServiceWidgetController controller;
  const GPSettingsView({super.key, required this.controller});

  @override
  State<GPSettingsView> createState() => _GPSettingsViewState();
}

class _GPSettingsViewState extends State<GPSettingsView> {
  final FocusNode claudeMessageFocusNode = FocusNode();

  late TextEditingController widthControler, heightControler;
  late Size size;

  ServicePrefs sharedPrefService = ServicePrefsImpl();
  bool isExpanded = false;

  void showMessageDialog(Widget child) {
    claudeMessageFocusNode.requestFocus();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(child: child);
      },
    );
  }

  // Close the options window to the left.
  void shrinkWindow() {
    // get the current size
    size = MediaQuery.of(context).size;

    windowManager.setSize(Size(size.width - 350, size.height));
    isExpanded = !isExpanded;
    setState(() {});
  }

  // Open the options window to the left.
  void expandWindow() {
    // get the current size
    size = MediaQuery.of(context).size;
    windowManager.setSize(Size(size.width + 350, size.height));
    isExpanded = !isExpanded;
    setState(() {});
  }

  @override
  void initState() {
    widthControler = TextEditingController();
    heightControler = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isExpanded ? 350 : 50,
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
                          value: "Claude",
                          child: Text(
                            "Claude",
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
                        if (val == "Claude") {
                          showMessageDialog(claudeNoticeDialog());
                        }

                        if(val == "Olm3.1-4B"){
                          showMessageDialog(ollamaSettingsDialog());
                          return;
                        }

                        widget.controller
                            .changeSelectedAgent(val ?? "Chat-GPT");
                        sharedPrefService.setDefaultAssistant(
                            agentName: val ?? "Chat-GPT");
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
                      controller: widthControler,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.grey[500],
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Current Width : ${size.width}",
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}'),
                        ), // Allow numbers and one decimal
                      ],
                      onSubmitted: (val) {
                        if (val == "") {
                          // Save the GPWI_WIDTH
                          sharedPrefService.saveDefaultWidth(
                              width: size.width - 300);
                          return;
                        }
                        // Save the GPWI_WIDTH
                        sharedPrefService.saveDefaultWidth(
                            width: double.parse(val));
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    height: 60,
                    width: double.maxFinite,
                    color: Colors.grey[850],
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 8.0, bottom: 12.0),
                    child: TextField(
                      controller: heightControler,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.grey[500],
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Current Height : ${size.height}",
                          hintStyle: TextStyle(color: Colors.grey[600])),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}'),
                        ), // Allow numbers and one decimal
                      ],
                      onSubmitted: (val) {
                        // Save the GPWI_HEIGHT
                        if (val == "") {
                          sharedPrefService.saveDefaultHeight(
                              height: size.height);
                          return;
                        }
                        sharedPrefService.saveDefaultHeight(
                            height: double.parse(val));
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
    );
  }

  Widget ollamaSettingsDialog(){
    return Container(
      width: 600,
      height: 700,
      color: Colors.grey[900],
      child: const WidgetOllamaInstallflow()
    );
  }

  Widget claudeNoticeDialog() {
    return Container(
      width: 600,
      height: 400,
      color: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Login Note",
            style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          const Text(
            "When using Claude please sign-in with email instead of google-signin. Claude doesn't support google signin on WebViews.",
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          KeyboardListener(
            focusNode: claudeMessageFocusNode,
            onKeyEvent: (val) {
              if (val is KeyDownEvent) {
                // Check if the Enter/Return key was pressed
                if (val.logicalKey == LogicalKeyboardKey.enter) {
                  // Dispose the popup.
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }
              }
            },
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Hit ⏎ to close\nTap here to close",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
