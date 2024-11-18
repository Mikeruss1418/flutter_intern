import 'package:flutter/material.dart';
import 'package:qn_1/screens/landing_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grid with Details',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GridScreen(),
    );
  }
}




