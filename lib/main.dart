import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const platform =
      MethodChannel("platform_channel_testing");

  const MyApp({super.key});

  Future<void> _navigateToNativeScreenA() async {
    try {
      await platform.invokeMethod('openNativeScreenA',{'msg':'Native Screen 1'});
    } on PlatformException catch (e) {
      print("Failed to navigate to A: '${e.message}'.");
    }
  }

  Future<void> _navigateToNativeScreenB() async {
    try {
      await platform.invokeMethod('openNativeScreenB',{'msg':'Native Screen 2'});
    } on PlatformException catch (e) {
      print('Failed to navigate to B : ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Screen')),
        body: Center(
          child: Column(
            children: [
              TextButton(
                onPressed: _navigateToNativeScreenA,
                child: const Text('Go to Native Screen A'),
              ),
              TextButton(
                onPressed: _navigateToNativeScreenB,
                child: const Text('Go to Native Screen B'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
