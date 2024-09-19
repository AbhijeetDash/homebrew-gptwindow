import 'package:flutter/material.dart';
import 'package:gptwidget/services/service_prefs.dart';
import 'package:window_manager/window_manager.dart';

class ServiceWidgetController extends ChangeNotifier {
  String selectedAgentValue = "Chat-GPT";
  String selectedAgentUrl = "https://chatgpt.com/";
  Size size = const Size(450, 900);

  ServiceWidgetController(){
    getDefaultSize();
    getDefaultAgent();
  }

  Future<void> getDefaultAgent() async {
    // get the last agent from shared prefs
    ServicePrefs sharedPrefService = ServicePrefsImpl();
    String assistants = await sharedPrefService.getDefaultAssistant();
    changeSelectedAgent(assistants);
  }

  void getDefaultSize() async {
    ServicePrefs sharedPrefService = ServicePrefsImpl();
    size = await sharedPrefService.getDefaultSize();
    
    // This is always in shrinked state
    windowManager.setSize(Size(size.width, size.height));
  }

  void changeSelectedAgent(String selection){
    if(selection == selectedAgentValue){
      return;
    }

    selectedAgentValue = selection;
    changeAgentUrl();
  }

  void changeAgentUrl(){
    // If this line shows error its because of Dart Extention on VSCode.
    // The extention is defined in the extentions.dart import above.
    // The Dart Extention is SHIT.
    selectedAgentUrl = selectedAgentValue.getAssistantURL();
    notifyListeners();
  }

  String get currentAgentUrl => selectedAgentUrl;
  String get currentAgentValue => selectedAgentValue;
}

extension on String {
  String getAssistantURL(){
    switch (this) {
      case "Chat-GPT":
        return "https://chatgpt.com/";
      case "Gemini":
        return "https://gemini.google.com/app";
      case "Olm3.1-4B":
        return "https://localhost:3000";
      case "Claude":
        return "https://claude.ai/new";
      default:
        return "https://chatgpt.com/";
    }
  }
}

