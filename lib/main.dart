import 'package:flutter/material.dart';
import 'package:gptwidget/application/application.dart';
import 'package:gptwidget/services/service_initializer.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // For hot reload, `unregisterAll()` needs to be called.
  await hotKeyManager.unregisterAll();

  // Create instance of all the required classes before the app starts.
  final ServiceInitializedImpl initService = ServiceInitializedImpl();

  // Initializing all that's necessary.
  initService.initializeHotKeys();
  initService.initializeWindowState();
  runApp(const GPTWidget());
}
