import 'package:shared_preferences/shared_preferences.dart';

enum Assistants { gpt, claude, gemini }

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
