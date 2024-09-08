import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

abstract class ServiceWebviewControler extends ChangeNotifier {
  void addRequestLink(String url);

  void getDefaultAgent();

  WebViewController get controler;
}

class ServiceWebviewControlerImpl extends ServiceWebviewControler {
  late WebViewController viewController;

  ServiceWebviewControlerImpl(){
    // This initializes the default controler
    // The javascript mode should always be unrestricted.
    viewController = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  // Get's the default agent from shared prefs.
  @override
  void getDefaultAgent() {}

  @override
  void addRequestLink(String url){
    viewController.loadRequest(Uri.parse(url));
    notifyListeners();
  }

  @override
  WebViewController get controler => viewController;
}