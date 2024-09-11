import 'package:shared_preferences/shared_preferences.dart';

enum Assistants { gpt, claude, gemeni }

extension on String {
  Assistants getAsistantFromName() {
    switch (this) {
      case "GPT":
        return Assistants.gpt;
      case "CLAUDE":
        return Assistants.claude;
      case "GEMENI":
        return Assistants.gemeni;
    }
    return Assistants.gpt;
  }
}

abstract class ServicePrefs {
  void getDefaultAssistant();

  void setDefaultAssistant();
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
  void setDefaultAssistant() {
    // TODO: implement setDefaultAssistant
  }
}
