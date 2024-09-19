import 'dart:ui';

import 'package:gptwidget/application/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ServicePrefs {
  Future<String> getDefaultAssistant();

  Future<void> setDefaultAssistant({required String agentName});

  Future<void> saveDefaultWidth({required double width});

  Future<void> saveDefaultHeight({required double height});

  Future<Size> getDefaultSize();
}

class ServicePrefsImpl extends ServicePrefs {
  @override
  Future<String> getDefaultAssistant() async {
    final prefs = await SharedPreferences.getInstance();
    String? strName = prefs.getString("GPWI_AGENT_NAME");

    if (strName != null) {
      // If this line shows error its because of Dart Extention on VSCode.
      // The extention is defined in the extentions.dart import above.
      // The Dart Extention is SHIT.
      return strName;
    }

    return "gpt";
  }

  @override
  Future<void> setDefaultAssistant({required String agentName}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("GPWI_AGENT_NAME", agentName);
  }
  
  @override
  Future<void> saveDefaultHeight({required double height}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble("GPWI_HEIGHT", height);
  }
  
  @override
  Future<void> saveDefaultWidth({required double width}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble("GPWI_WIDTH", width);
  }
  
  @override
  Future<Size> getDefaultSize() async {
    final prefs = await SharedPreferences.getInstance();
    double width = prefs.getDouble("GPWI_WIDTH")??450.0;
    double height = prefs.getDouble("GPWI_HEIGHT")??900.0;
    return Size(width, height);
  }
}

extension on String {
  Assistants getAsistantFromName() {
    switch (this) {
      case "GPT":
        return Assistants.gpt;
      case "CLAUDE":
        return Assistants.claude;
      case "GEMINI":
        return Assistants.gemini;
    }
    return Assistants.gpt;
  }
}
