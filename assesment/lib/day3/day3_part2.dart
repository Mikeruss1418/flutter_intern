/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Show button',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var showall = false;

  List data = List.generate(10, (index) {
    return {
      'leading': '${index + 1}',
      'title': 'Title ${index + 1}',
      'short_detail': 'This is about title no. ${index + 1}',
      'date': DateFormat('yMMMMd')
          .format(DateTime.now().add(Duration(days: index))),
    };
  });

  @override
  Widget build(BuildContext context) {
    var displaylist = showall ? data : data.take(5).toList();
    //
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 5,
        backgroundColor: Colors.blue,
        title: Text('Title'),
      ),
      body: ListView.builder(
        itemCount: displaylist.length +
            1, //here, instead of data.length,displaylist.length+1 is used as
        //if showall is false, it will have 5 element , if not it will have all the elements
        //the +1 is for show more or show less button
        itemBuilder: (context, index) {
          //
          if (index == displaylist.length) {
            return TextButton(
                onPressed: () {
                  setState(() {
                    showall = !showall; //showall turns to true
                  });
                },
                child: Text(showall ? 'Show less' : 'Show More'));
          }

          return Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 184, 175, 175).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ]),
            child: ListTile(
              leading: Icon(
                Icons.account_circle_sharp,
                size: 50,
              ),
              title: Text(data[index]['title']),
              subtitle: Text(
                  '${data[index]['short_detail']}\n${data[index]['data']}'),
              trailing: Icon(Icons.account_circle),
            ),
          );
        },
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showAll = false;
  List dataList = List.generate(
      20,
      (index) => {
            'title': 'Item ${index + 1}',
            'description': 'This is the description for item ${index + 1}.',
            'date': DateFormat('yMMMMd')
                .format(DateTime.now().add(Duration(days: index))),
            'subItems': List.generate(
                5, (subIndex) => 'SubItem $subIndex for Item ${index + 1}')
          });

  @override
  Widget build(BuildContext context) {
    final displayList = showAll ? dataList : dataList.take(5).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('List View Demo'),
      ),
      body: ListView.builder(
        itemCount: displayList.length + 1,
        itemBuilder: (context, index) {
          if (index == displayList.length) {
            return Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    showAll = !showAll;
                  });
                },
                child: Text(showAll ? 'Show Less' : 'Show More'),
              ),
            );
          } else {
            var item = displayList[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              elevation: 3,
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                leading: Icon(Icons.image, size: 40, color: Colors.blue),
                title: Text(
                  item['title'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['description'],
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Text(
                      item['date'],
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  // Define your onTap action here
                },
              ),
            );
          }
        },
      ),
    );
  }
}
