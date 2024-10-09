import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // Called once when the stateful widget is inserted in the widget tree
    print('initState called');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Called when a dependency of this State object changes
    print('didChangeDependencies called');
  }

  @override
  void didUpdateWidget(CounterScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Called whenever the widget configuration changes
    print('didUpdateWidget called');
  }

  @override
  void dispose() {
    // Called when this object is removed from the tree permanently
    print('dispose called');
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Called whenever the widget is rebuilt
    print('build called');

    return Scaffold(
      appBar: AppBar(
        title: Text('Stateful Widget Lifecycle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
