import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

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
      appBar: AppBar(
        title: const Text('Scrollable Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "Horizontal Scroll",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              horizontal(),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Vertical Scroll',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              vertical(),
            ],
          ),
        ),
      ),
    );
  }

  Widget vertical() {
    var displaylist = show ? _netwokimage.take(5).toList() : _netwokimage;
    return ListView.builder(
      shrinkWrap: true,
      //
      physics: NeverScrollableScrollPhysics(),
      itemCount: displaylist.length + 1,
      itemBuilder: (context, index) {
        if (index == displaylist.length) {
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
        return SizedBox(
          height: 120,
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 5),
            color: Color.fromARGB(255, 216, 225, 217),
            elevation: 10,
            clipBehavior: Clip.antiAlias,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100, // Constrained width
                  height: 80, // Constrained height
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      displaylist[index]['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  // Use Expanded to take available space
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(displaylist[index]['title']!,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text(displaylist[index]['Description']!),
                      SizedBox(height: 8),
                      Text(date),
                    ],
                  ),
                ),
                Icon(Icons.add_box),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget horizontal() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _localimage.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(right: 5),
            height: 150,
            child: Row(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey,
                  ),
                  child: Image.asset(
                    _localimage[index]['image']!,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Text('Title'),
                SizedBox(
                  width: 15,
                ),
                Text(date),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
