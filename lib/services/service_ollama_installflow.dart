import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

abstract class ServiceOllamaInstallflow {
  Stream<String> get outputStream;

  Future<void> runBashScript();

  void dispose();
}

class ServiceOllamaInstallflowImpl extends ServiceOllamaInstallflow {
  StreamController<String> outputController = StreamController<String>();

  @override
  Stream<String> get outputStream => outputController.stream;

  @override
  Future<void> runBashScript() async {
    try {
      // Load the script from the assets
      String scriptContent =
          await rootBundle.loadString('assets/install_ollama.sh');

      // Get the temp directory
      Directory tempDir = await getTemporaryDirectory();

      // Create a temp file for the script
      File tempScript = File('${tempDir.path}/install_ollama.sh');

      // Write the script content to the temp file
      await tempScript.writeAsString(scriptContent);

      // Make the script executable
      await Process.run('chmod', ['+x', tempScript.path]);

      // Start the process
      Process process = await Process.start('bash', [tempScript.path]);

      // Listen to stdout (standard output) and add to StreamController
      process.stdout.transform(utf8.decoder).listen((data) {
        print(data);
        outputController.add(data); // Add data to the stream
      });

      // Listen to stderr (standard error) and add to StreamController
      process.stderr.transform(utf8.decoder).listen((data) {
        outputController
            .add('Error: $data'); // Add error messages to the stream
      });

      // Wait for the process to finish
      await process.exitCode;
    } catch (e) {
      outputController.add('Error running script: $e');
    }
  }

  @override
  void dispose() {
    outputController.close();
  }
}
