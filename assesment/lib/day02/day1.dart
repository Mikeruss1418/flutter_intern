import 'package:assesment/constants/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(app());
}

class app extends StatelessWidget {
  const app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "day01",
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var txt = Text('button');
  var txt1 = Text('clickme!');
  var wcon = const Color.fromARGB(255, 131, 114, 63);

  //for floatingaction button
  var number = 0;

  //elevatedbutton
  var wid = 150.0;
  var hid = 85.0;

  void _textchange() {
    setState(() {
      txt = Text('button clicked ${Random().nextInt(255)}');
      txt1 = Text('Clicked IT!! ${Random().nextInt(255)}');
      wcon = Color.fromARGB(
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
      );
      wid = 150 + (Random().nextDouble() * (450 - 150));
      hid = 85 + (Random().nextDouble() * (150 - 85));
    });
  }

  void _increment() {
    setState(() {
      number++;
      wid = Random().nextDouble() * (250 - 150);
      hid = Random().nextDouble() * (175 - 85);
    });
  }

  void _decrement() {
    setState(() {
      if (number > 0) {
        number--;
      } else {
        number = 0;
      }
      wid = Random().nextDouble() * (250 - 150);
      hid = Random().nextDouble() * (125 - 50);
    });
  }

  var _imageindex = 0;

  var _imagelist = [
    'https://images.unsplash.com/photo-1541324198302-6be2ef1b699a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1676637000058-96549206fe71?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1686931548830-228c29d3b805?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
  ];

  void _next() {
    setState(() {
      if (_imageindex < _imagelist.length - 1) {
        _imageindex++;
      }
    });
  }

  void _prev() {
    setState(() {
      if (_imageindex > 0) {
        _imageindex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'day01',
          style: txtsty,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              stdcon(
                color: wcon,
                child: Center(
                  child: txt,
                ),
              ),
              stdcon(
                color: wcon,
                child: TextButton(
                  onPressed: _textchange,
                  child: txt1,
                ),
              ),
              Container(
                width: wid.toDouble(),
                height: hid.toDouble(),
                margin: EdgeInsets.symmetric(vertical: 10),
                color: wcon,
                child: ElevatedButton(
                  onPressed: _textchange,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    elevation: 20,
                  ),
                  child: txt1,
                ),
              ),
              Text('$number'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: wid,
                    height: hid,
                    color: wcon,
                    child: FloatingActionButton(
                      onPressed: _increment,
                      tooltip: "Increment", //shows when long pressed
                      child: Icon(Icons.add),
                    ),
                  ),
                  Container(
                    width: wid,
                    height: hid,
                    color: wcon,
                    child: FloatingActionButton(
                      onPressed: _decrement,
                      tooltip: "Decrement", //shows when long pressed
                      child: Icon(Icons.remove),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                child: Image.network(
                  _imagelist[_imageindex],
                  width: 250,
                  height: 150,
                  //fit: BoxFit.contain,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: FloatingActionButton(
                      onPressed: _prev,
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: _next,
                    child: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
