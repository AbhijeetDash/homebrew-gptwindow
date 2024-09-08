import 'package:flutter/material.dart';
import 'package:gptwidget/services/service_webview_controler.dart';
import 'package:gptwidget/widgets/widget_settings_view.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:window_manager/window_manager.dart';

class WidgetWindow extends StatefulWidget {
  const WidgetWindow({super.key});

  @override
  State<WidgetWindow> createState() => _WidgetWindowState();
}

class _WidgetWindowState extends State<WidgetWindow> {
  late final ServiceWebviewControler controller;
  late Size size;

  bool isExpanded = false;

    // Close the options window to the left.
  void shrinkWindow() {
    windowManager.setSize(const Size(450, 900));
    isExpanded = !isExpanded;
    setState(() {});
  }

  // Open the options window to the left.
  void expandWindow() {
    windowManager.setSize(const Size(850, 900));
    isExpanded = !isExpanded;
    setState(() {});
  }


  @override
  void initState() {
    controller = ServiceWebviewControlerImpl();
    WidgetsBinding.instance.addPostFrameCallback((_){
      controller.addRequestLink("https://www.chatgpt.com");
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SizedBox(
        width: size.width,
        child: Stack(
          children: [
            IconButton(onPressed: (){
              // change the window width.
              if(isExpanded){
                shrinkWindow();
                return;
              }

              expandWindow();
            }, icon: const Icon(Icons.settings),),
            // Is the layout constraint for the row.
            SizedBox(
              width: size.width,      
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 450,
                    child: ListenableBuilder(
                      listenable: controller,
                      builder: (context, snap) {
                        return WebViewWidget(controller: controller.controler);
                      },
                    ),
                  ),
                  if(isExpanded)
                    const SettingsView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
