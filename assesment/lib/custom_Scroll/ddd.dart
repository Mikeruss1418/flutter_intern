import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('GridView Example')),
        body: GridViewContainer(),
      ),
    );
  }
}

class GridViewContainer extends StatefulWidget {
  @override
  _GridViewContainerState createState() => _GridViewContainerState();
}

class _GridViewContainerState extends State<GridViewContainer> {
  final List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange
  ];
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Subtitle'),
            Text(
              'Date: ${DateTime.now()}',
              style: TextStyle(color: Colors.grey),
            ),
            Divider(
              color: Colors.grey,
              thickness: 10.0,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: showAll ? 20 : 10,
                itemBuilder: (context, index) {
                  return Container(
                    color: colorList[index % colorList.length],
                    child: index % 2 == 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image, size: 50),
                              Text('Item $index'),
                            ],
                          )
                        : Image.network('https://via.placeholder.com/150'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showAll = !showAll;
                });
              },
              child: Text(showAll ? 'View Less' : 'View More'),
            ),
          ],
        ),
      ),
    );
  }
}
