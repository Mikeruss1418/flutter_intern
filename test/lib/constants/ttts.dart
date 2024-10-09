import 'package:flutter/material.dart';

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    // Initialize state here
    _counter = 0;
  }
  @override
  void didUpdateWidget(MyStatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Handle widget updates here
  }
  @override
  Widget build(BuildContext context) {//build method
    return Scaffold(
      appBar: AppBar(
        title: Text('Stateful Widget Lifecycle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Counter: $_counter'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // Clean up resources here
    super.dispose();
  }
}
