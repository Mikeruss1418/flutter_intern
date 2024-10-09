import 'package:flutter/material.dart';
import 'package:assesment/day01/day1.dart';

Color background_color = Color.fromARGB(255, 237, 235, 228);
Color appbar_color = Color.fromARGB(255, 215, 173, 49);

TextStyle txtsty = TextStyle(
  fontSize: 20,
  color: Colors.amber,
);

class stdcon extends StatelessWidget {
  final Widget child;
  final color;
  const stdcon({super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),
        color: color,
      ),
      child: child,
    );
  }
}
