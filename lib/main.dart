import 'package:flutter/material.dart';
import 'package:gptwidget/service_initializer.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // For hot reload, `unregisterAll()` needs to be called.
  await hotKeyManager.unregisterAll();

  // Create instance of all the required classes before the app starts.
  final ServiceInitializedImpl initService = ServiceInitializedImpl();

  // Initializing all that's necessary.
  initService.initializeHotKeys();
  initService.initializeWindowState();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPT Widget',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            // print(url);
          },
          onPageFinished: (String url) {
            // print(url);
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {
            // print(error);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://chatgpt.com/'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebViewWidget(controller: controller));
  }
}
