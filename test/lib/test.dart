import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculate',
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var fnumber = TextEditingController();
  var snumber = TextEditingController();
  var result = ' ';

  void _add() {
    var n1 = int.parse(fnumber.text.toString());
    var n2 = int.parse(snumber.text.toString());

    var calculation = n1 + n2;
    setState(() {
      result = '$calculation';
    });
  }

  void _sub() {
    var n1 = int.parse(fnumber.text.toString());
    var n2 = int.parse(snumber.text.toString());

    var calculation = n1 - n2;
    setState(() {
      result = '$calculation';
    });
  }

  void _multipy() {
    var n1 = int.parse(fnumber.text.toString());
    var n2 = int.parse(snumber.text.toString());
    var calculation = n1 * n2;
    setState(() {
      result = '$calculation';
    });
  }

  void _divide() {
    var n1 = int.parse(fnumber.text.toString());
    var n2 = int.parse(snumber.text.toString());
    var calculation = n1 / n2;
    setState(() {
      result = '$calculation';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculate'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: fnumber,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.amber,
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.amber,
                    width: 2,
                  ),
                ),
                labelText: 'Enter a number',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: snumber,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.amber,
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.amber,
                    width: 2,
                  ),
                ),
                labelText: 'Enter a number',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 167, 166, 159),
                  side: BorderSide(
                    color: Colors.amber,
                    width: 2,
                  ),
                ),
                onPressed: _add,
                child: Text('+'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 167, 166, 159),
                  side: BorderSide(
                    color: Colors.amber,
                    width: 2,
                  ),
                ),
                onPressed: _sub,
                child: Text('-'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 167, 166, 159),
                  side: BorderSide(
                    color: Colors.amber,
                    width: 2,
                  ),
                ),
                onPressed: _multipy,
                child: Text('*'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 167, 166, 159),
                  side: BorderSide(
                    color: Colors.amber,
                    width: 2,
                  ),
                ),
                onPressed: _divide,
                child: Text('/'),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            // decoration: BoxDecoration(
            //   color: Colors.amber,
            // ),
            child: Center(
              child: Text(
                result,
                style: TextStyle(fontSize: 30),
              ),
            ),
          )
        ],
      ),
    );
  }
}
