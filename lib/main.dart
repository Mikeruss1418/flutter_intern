import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
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
  var icolor = Color.fromARGB(255, 80, 76, 65);
  var itxt = Text('Click me');
  var index = 0;
  var wid = 200.0;
  var ecolor = const Color.fromARGB(255, 245, 186, 7);
  var jcolor = const Color.fromARGB(255, 250, 188, 5);
  var result = '';
  int counter = 0;
  Icon iforward = Icon(Icons.arrow_forward_rounded);
  Icon ibackward = Icon(Icons.arrow_back_rounded);

  var incrbtn = const Color.fromARGB(255, 95, 81, 39);
  var decrbtn = const Color.fromARGB(255, 95, 81, 39);
//
  var _imagelist = [
    'https://images.unsplash.com/photo-1541324198302-6be2ef1b699a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1676637000058-96549206fe71?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1686931548830-228c29d3b805?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
  ];

  var imageindex = 0;
//
  void _next() {
    setState(() {
      iforward = Icon(Icons.arrow_forward_ios_rounded);
      if (imageindex < _imagelist.length - 1) {
        imageindex++;
      }
    });
  }

  void _prev() {
    setState(() {
      ibackward = Icon(Icons.arrow_back_ios_new);
      if (imageindex > 0) {
        imageindex--;
      }
    });
  }

  void _txtbtnColor() {
    setState(() {
      icolor = Color.fromARGB(
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
      );
      index++;
      itxt = Text('Click me $index');
    });
  }

  void _elbtnColor() {
    setState(() {
      jcolor = Color.fromARGB(
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
      );
      ecolor = Color.fromARGB(
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
      );
      wid = 250 + (Random().nextDouble() * (400 - 200));
    });
  }

  void _increment() {
    setState(() {
      incrbtn = Color.fromARGB(
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
      );
      counter++;
    });
  }

  void _decrement() {
    setState(() {
      decrbtn = Color.fromARGB(
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
      );
      if (counter > 0) {
        counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text('Title'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: _txtbtnColor,
                style: TextButton.styleFrom(
                  backgroundColor: icolor,
                ),
                child: itxt,
              ),
              Container(
                color: ecolor,
                width: wid,
                height: 200, //200-400
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ecolor,
                    ),
                    onPressed: _elbtnColor,
                    child: Text("Elevated button click"),
                  ),
                ),
              ),
              Text('$counter'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: FloatingActionButton(
                      backgroundColor: incrbtn,
                      onPressed: _increment,
                      child: Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: FloatingActionButton(
                      backgroundColor: decrbtn,
                      onPressed: _decrement,
                      child: Icon(
                        Icons.remove,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: Image.network(_imagelist[imageindex]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    onPressed: _prev,
                    child: ibackward,
                  ),
                  FloatingActionButton(
                    onPressed: _next,
                    child: iforward,
                  ),
                ],
              ),
              Center(
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.asset('assets/images/test.jpg'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
