import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Tabs4 extends StatefulWidget {
  const Tabs4({super.key});

  @override
  State<Tabs4> createState() => _Tabs4State();
}

class _Tabs4State extends State<Tabs4> {
  bool show = true;

  final _gridValues = List.generate(
      20,
      (index) => {
            'title': 'This is ${index + 1}',
            'text': 'Num ${index + 1}',
            //'subtitle': DateFormat('yMMMMd').format(DateTime.now()),
            'image':
                'https://www.publicdomainpictures.net/pictures/170000/velka/landschaft-1463581037RbE.jpg',
          });

  final _color = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.blue,
    Colors.deepOrange,
  ];

  @override
  Widget build(BuildContext context) {
    var displaylist = show ? _gridValues.take(10).toList() : _gridValues;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 232, 230, 230),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(25, 50),
                  )
                ]),
            child: Column(
              children: [
                Text(
                  'Assessment',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: _color[1]),
                ),
                const Text(
                  'This is the Day 4 Assessment',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  DateFormat('yMMMMdd').format(
                    DateTime.now(),
                  ),
                  style: const TextStyle(color: Colors.purple, fontSize: 20),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Divider(
                  color: _color[0],
                  // endIndent: 25,
                  // indent: 25,
                  thickness: 10,
                  height: 50,
                ),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15), //for indiviual grid padding

                    itemCount: displaylist.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      if (index == displaylist.length) {
                        return Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                show = !show;
                              });
                            },
                            child: Text(show ? 'View More' : 'View less'),
                          ),
                        );
                      }

                      return Center(
                        child: Container(
                          color: _color[index],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                minRadius: 25,
                                backgroundImage:
                                    NetworkImage(_gridValues[index]['image']!),
                              ),
                              Text(_gridValues[index]['text']!)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
