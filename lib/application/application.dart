import 'package:flutter/material.dart';
import 'package:gptwidget/window/window_widget.dart';

class GPTWidget extends StatefulWidget {
  const GPTWidget({super.key});

  @override
  State<GPTWidget> createState() => _GPTWidgetState();
}

class _GPTWidgetState extends State<GPTWidget> {
  
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
      home: const WidgetWindow(),
    );
  }
}