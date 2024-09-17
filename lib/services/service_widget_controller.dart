import 'package:flutter/material.dart';

class ServiceWidgetController extends ChangeNotifier {
  String selectedAgentValue = "Chat-GPT";
  String selectedAgentUrl = "https://chatgpt.com/";

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
      default:
        return "https://chatgpt.com/";
    }
  }
}

