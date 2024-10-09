import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test/constants/colors.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TextField",
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
  //here all the declaration are made outside the build ,show that it doesn't be recreated everytime on hot reload
  final email = TextEditingController();
  final password = TextEditingController();
  var txt = Text('Login');
  DateTime? selecteddate; //

  //eye button
  bool _obscureTxt = true;

  void _see() {
    setState(() {
      _obscureTxt = !_obscureTxt;
    });
  }

  void _selectdate(BuildContext context) async {
    var picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    // ignore: unrelated_type_equality_checks
    if (picked != selecteddate) {
      setState(() {
        selecteddate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      appBar: AppBar(
        title: Text("TextField"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 100,
        ),
        child: SingleChildScrollView(
          //should be applied as it also calulates for the keyboard pop_up
          child: Column(
            children: [
              Align(alignment: Alignment.centerLeft, child: Text("Email")),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.amber,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Password"),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: password,
                  obscureText: _obscureTxt,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureTxt
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: _see,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.amber,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _selectdate(context);
                },
                child: Text('D.O.B'),
              ),
              ElevatedButton(
                onPressed: () {
                  var ename = email;
                  var pname = password;
                  var dob = selecteddate != null
                      ? selecteddate.toString().split(' ')[
                          0] //selecteddate is converted to string and then splited to get the date part only through [0]
                      : 'not seleceted';

                  print('Email: $ename');
                  print('Password: $pname');
                  print('DOB: $dob');
                },
                child: txt,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
