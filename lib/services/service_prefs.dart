import 'package:gptwidget/application/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ServicePrefs {
  Future<Assistants> getDefaultAssistant();

  Future<void> setDefaultAssistant({required String agentName});
}

class ServicePrefsImpl extends ServicePrefs {
  @override
  Future<Assistants> getDefaultAssistant() async {
    final prefs = await SharedPreferences.getInstance();
    String? strName = prefs.getString("GPWI_AGENT_NAME");

    if (strName != null) {
      // If this line shows error its because of Dart Extention on VSCode.
      // The extention is defined in the extentions.dart import above.
      // The Dart Extention is SHIT.
      return strName.getAsistantFromName();
    }

    return Assistants.gpt;
  }

  @override
  Future<void> setDefaultAssistant({required String agentName}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("GPWI_AGENT_NAME", agentName);
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
