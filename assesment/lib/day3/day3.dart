/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List',
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _images = [
    {
      'image':
          c
      'title': 'Image 1'
    },
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1676637000058-96549206fe71?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
      'title': 'Image 2'
    },
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1676637000058-96549206fe71?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
      'title': 'Image 3'
    },
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1676637000058-96549206fe71?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
      'title': 'Image 4'
    },
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1676637000058-96549206fe71?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
      'title': 'Image 5'
    },
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1676637000058-96549206fe71?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
      'title': 'Image 6'
    },
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1676637000058-96549206fe71?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
      'title': 'Image 7'
    },
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1676637000058-96549206fe71?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
      'title': 'Image 8'
    },
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1676637000058-96549206fe71?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
      'title': 'Image 9'
    },
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1676637000058-96549206fe71?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
      'title': 'Image 10'
    },
  ];

  var title = [
    'T1',
    'T2',
    'T3',
    'T4',
    'T5',
    'T6',
    'T7',
    'T8',
    'T9',
    'T10',
  ];

  var date = [
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        child: Title(
        color: Colors.white,
          child: ListView.builder(
            //scrollDirection: Axis.horizontal,
            itemCount: _images.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Image.network(
                        _images[index]['image']!,
                        width: 150,
                        height: 75,
                      ),
                      Text(
                        _images[index]['title']!,
                      ),
                      Text(
                        title[index],
                      ),
                      Text(
                        DateFormat('yMMMMd').format(date[index]),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView Example',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  final List dataList = List.generate(10, (index) {
    return {
      'title': 'Item ${index + 1}',
      'description': 'This is the description for item ${index + 1}.',
      'date': DateFormat('yMMMMd')
          .format(DateTime.now().add(Duration(days: index))),
      'subItems': List.generate(
          5, (subIndex) => 'SubItem ${subIndex + 1} for Item ${index + 1}')
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Example'),
      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 110, 48, 48).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataList[index]['title']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    dataList[index]['description']!,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 100, // Height for the inner ListView
                    child: ListView.builder(
                      itemCount: dataList[index]['subItems'].length,
                      itemBuilder: (context, subIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(dataList[index]['subItems'][subIndex]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts',
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
  bool show_more = true;
  List contacts = [
    {'name': 'Rojesh shrestha', 'phone': '9876543210'},
    {'name': 'Uniq subedi', 'phone': '9846569822'},
    {'name': 'Ajay Maharjan', 'phone': '9865321675'},
    {'name': 'Rojesh shrestha', 'phone': '9876543210'},
    {'name': 'Uniq subedi', 'phone': '9846569822'},
    {'name': 'Ajay Maharjan', 'phone': '9865321675'},
    {'name': 'Rojesh shrestha', 'phone': '9876543210'},
    {'name': 'Uniq subedi', 'phone': '9846569822'},
    {'name': 'Ajay Maharjan', 'phone': '9865321675'},
    {'name': 'Rojesh shrestha', 'phone': '9876543210'},
    {'name': 'Uniq subedi', 'phone': '9846569822'},
    {'name': 'Ajay Maharjan', 'phone': '9865321675'},
    {'name': 'Rojesh shrestha', 'phone': '9876543210'},
    {'name': 'Uniq subedi', 'phone': '9846569822'},
    {'name': 'Ajay Maharjan', 'phone': '9865321675'},
    {'name': 'Rojesh shrestha', 'phone': '9876543210'},
    {'name': 'Uniq subedi', 'phone': '9846569822'},
    {'name': 'Ajay Maharjan', 'phone': '9865321675'},
  ];

  @override
  Widget build(BuildContext context) {
    var displaylist = show_more ? contacts.sublist(0, 10) : contacts;
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView.builder(
        //item count is of 
        itemCount: displaylist.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == displaylist.length) {
            return Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    show_more = !show_more;
                  });
                },
                child: Text(show_more ? 'Show more' : 'Show less'),
              ),
            );
          } else {
            var item = displaylist[index];
            return ListTile(
              leading: CircleAvatar(
                child: FaIcon(FontAwesomeIcons.personCircleCheck),
              ),
              title: Text(item['name']),
              subtitle: Text(item['phone']),
            );
          }
        },
      ),
    );
  }
}
