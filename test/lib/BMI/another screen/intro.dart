import 'package:flutter/material.dart';
import 'package:test/BMI/another%20screen/home.dart';

class intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Intro"),
      ),
      body: Column(
        children: [
          Text('Welcome'),
          SizedBox(
            height: 11,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Text('next page'))
        ],
      ),
    );
  }
}
