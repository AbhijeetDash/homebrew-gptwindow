import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:window_manager/window_manager.dart';

enum LoginState {
  stepOne,
  stepTwo,
  done,
}

const platform = MethodChannel('com.vera.app');

abstract class ServiceInitializer {
  void initializeWindowState();

  void initializeHotKeys();
}

class ServiceInitializedImpl extends ServiceInitializer {
  bool isWindowVisible = true;
  late Offset initialPosition;
 
  void _manageWindowView() async {
    if (isWindowVisible) {
      _hideWindowInCurrentWorkspace();
      isWindowVisible = false;
      return;
    }

    _showWindowInCurrentWorkspace();
    await windowManager.focus();
    isWindowVisible = true;
    return;
  }

  @override
  void initializeWindowState() async {
    // Ensuring the window manager is initialised in the package.
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      center: false,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );

    _resetWindowSize();

    if (Platform.isMacOS) {
      return;
    }
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
    });
  }

  @override
  void initializeHotKeys() async {
    // Need to get the saved hot key.
    hotKeyManager.register(
        HotKey(
            key: LogicalKeyboardKey.space,
            scope: HotKeyScope.system,
            modifiers: [HotKeyModifier.control]), keyDownHandler: (hotkey) {
      _manageWindowView();
    });
    return;
  }

  Future<void> _resetWindowSize() async {
    try {
      await platform.invokeMethod('resetWindowWidth');
    } catch (e) {
       throw Exception("Failed to reset window: $e");
    }
  }

  Future<void> _showWindowInCurrentWorkspace() async {
    try {
      await platform.invokeMethod('showWindowInCurrentWorkspace');
    } on PlatformException catch (e) {
      throw Exception("Failed to show window: ${e.message}");
    }
  }

  Future<void> _hideWindowInCurrentWorkspace() async {
    try {
      await platform.invokeMethod('hideWindowInCurrentWorkspace');
    } on PlatformException catch (e) {
      throw Exception("Failed to show window: ${e.message}");
    }
  }
}
