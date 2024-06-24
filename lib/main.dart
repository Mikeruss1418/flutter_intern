import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Day 3',
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
  //
  //
  bool show = true;

  var date = DateFormat('yMMMMdd').format(DateTime.now());
  final _localimage = List.generate(
    10,
    (index) =>
        {'title': 'Local Image${index + 1}', 'image': 'assets/images/test.jpg'},
  );

  final _netwokimage = List.generate(
    10,
    (index) => {
      'title': 'Network Image${index + 1}',
      'Description': 'This is the description of Image ${index + 1}',
      'image':
          'https://www.publicdomainpictures.net/pictures/170000/velka/landschaft-1463581037RbE.jpg',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 229, 223),
      appBar: AppBar(
        title: Text('DAy3'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            vertical1(),
            const Text(
              "Horizontal Scroll",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            //local image with horizontal direction scroll
            horizontal(),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Vertical Scroll',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            //vertical
            vertical()
          ],
        ),
      ),
    );
  }

  Widget vertical1() {
    return Text('Hellolsdnfjsadfs');
  }

  Widget vertical() {
    var displaylist = show ? _netwokimage.take(5) : _netwokimage;
    /*created a duplicate list,[displaylist] which contains all the data of _networkimages
    here, i used a method .take(int) which takes first five elements from the original LIst.
    then, proceed through the conditions*/
    return Flexible(
      flex: 3,
      child: ListView.builder(
        itemCount: displaylist.length + 1,
        /*as all the elements of the original List was shifted to displaylist, and the conditions are also applied 
        to this List variable.
        displaylist.length was used,
        here, it was done to preserved original List and 
        the +1 was kept for the show more/show less button*/
        itemBuilder: (context, index) {
          if (index == displaylist.length) {
            /*here when the index and the length of the displaylist are equal,
            I.E either it can be 5 or 10,
            tis if condition executes*/
            return Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    show = !show;
                  });
                },
                child: Text(
                  show ? 'Show more' : 'Show less',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
            );
          }
          return Container(
            //color: Colors.blue,
            child: Container(
              height: 150,
              child: Card(
                color: Color.fromARGB(255, 216, 225, 217),
                elevation: 10,
                clipBehavior: Clip.antiAlias,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        //height: 150,
                        width: 150,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            //color: Colors.grey,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 5,
                                blurRadius: 7,
                                color: Color.fromARGB(255, 160, 159, 157),
                                offset: Offset(20, 10),
                              )
                            ]),
                        child: Image.network(_netwokimage[index]['image']!,
                            fit: BoxFit.fitHeight),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('title'),
                        SizedBox(
                          height: 5,
                        ),
                        Text('description'),
                        SizedBox(
                          height: 8,
                        ),
                        Text(date),
                      ],
                    ),
                    Icon(
                      (Icons.add_box),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget horizontal() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _localimage.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(right: 5),
            height: 150,
            //color: Colors.amber,
            child: Row(children: [
              Container(
                height: 150,
                width: 150,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey,
                ),
                child: Image.asset(_localimage[index]['image']!,
                    fit: BoxFit.fitHeight),
              ),
              SizedBox(
                width: 8,
              ),
            ]),
          );
        },
      ),
    );
  }
}
