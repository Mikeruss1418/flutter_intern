import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //MethodChannel fun
  static const platform = MethodChannel("platform_channel_testing");
  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler(
      (call) async {
        if (call.method == "onDataReceived") {
         await _dataFromNativeScreen(call);
        } else if (call.method == "onDataReceived01") {
         await _dataFromSecondNativeScreen(call);
        }
        return;
      },
    );
    // platform.setMethodCallHandler(_dataFromNativeScreen);
    // platform.setMethodCallHandler(_dataFromSecondNativeScreen);
  }

//from native
  Future<void> _dataFromNativeScreen(MethodCall call) async {
    if (call.method == "onDataReceived") {
      final String data = call.arguments as String;
      setState(() {
        // update Ui
        returnedDataof1st = data;
      });
    }
  }

  Future<void> _dataFromSecondNativeScreen(MethodCall call) async {
    if (call.method == "onDataReceived01") {
      final String data01 = call.arguments as String;
      setState(() {
        returnedDataof2nd = data01;
      });
    }
  }

////
  ///to native
  Future<void> _navigateToNativeScreenA() async {
    try {
      await platform
          .invokeMethod('openNativeScreenA', {'msg': firstScreen.text});
      firstScreen.clear();
    } on PlatformException catch (e) {
      log("Failed to navigate to A: '${e.message}'.");
    }
  }

  Future<void> _navigateToNativeScreenB() async {
    try {
      await platform
          .invokeMethod('openNativeScreenB', {'msg': secondScreen.text});
      secondScreen.clear();
    } on PlatformException catch (e) {
      log('Failed to navigate to B : ${e.message}');
    }
  }

////
  ///
  TextEditingController firstScreen = TextEditingController();
  String returnedDataof1st = '';
  String returnedDataof2nd = '';

  TextEditingController secondScreen = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Screen')),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextField(
                  controller: firstScreen,
                  decoration: InputDecoration(
                      hintText: "First Screen data passing",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      )),
                ),
              ),
              Text("FirstScreen Data: $returnedDataof1st"),
              TextButton(
                onPressed: _navigateToNativeScreenA,
                child: const Text('Go to Native Screen A'),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextField(
                  controller: secondScreen,
                  decoration: InputDecoration(
                      hintText: "Second Screen data passing",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      )),
                ),
              ),
              Text("SecondScreen Data: $returnedDataof2nd"),
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
