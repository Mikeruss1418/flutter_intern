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
  final  _images = [
    {'image': 'assets/images/test.jpg', 'title': 'Image 1'},
    {'image': 'assets/images/test.jpg', 'title': 'Image 2'},
    {'image': 'assets/images/test.jpg', 'title': 'Image 3'},
    {'image': 'assets/images/test.jpg', 'title': 'Image 4'},
    {'image': 'assets/images/test.jpg', 'title': 'Image 5'},
    {'image': 'assets/images/test.jpg', 'title': 'Image 6'},
    {'image': 'assets/images/test.jpg', 'title': 'Image 7'},
    {'image': 'assets/images/test.jpg', 'title': 'Image 8'},
    {'image': 'assets/images/test.jpg', 'title': 'Image 9'},
    {'image': 'assets/images/test.jpg', 'title': 'Image 10'},
  ];

  var date = DateTime.now();

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
              return Card(
                shadowColor: Colors.amber,
                elevation: 5,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(_images[index]['image']!),
                  ),
                  title: Text(_images[index]['title']!),
                  subtitle: Text(DateFormat('yMMMMd').format(date)),
                  trailing: Icon(
                    Icons.add_box,
                    size: 35,
                  ),
                ),
              );
            },
          ),
        ),
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List of local images with titles
  final List<Map<String, String>> _localImages = List.generate(
    10,
    (index) => {
      'image': 'assets/images/test.jpg', // Ensure this image is added to assets
      'title': 'Local Image ${index + 1}'
    },
  );

  // List of network images with titles and descriptions
  final List<Map<String, String>> _networkImages = List.generate(
    10,
    (index) => {
      'image': 'data:image/jpeg;base64,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',
      'title': 'Network Image ${index + 1}',
      'description': 'Description for Image ${index + 1}',
    },
  );

  bool _showAllItems = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListViews with Images and Text'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Horizontal ListView for local images
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _localImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 250,
                    height: 50,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display local image
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                          child: Image.asset(
                            _localImages[index]['image']!,
                            width: 250,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _localImages[index]['title']!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                DateFormat('yyyy-MM-dd – kk:mm')
                                    .format(DateTime.now()),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Container for vertical ListView
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vertical ListView with Network Images',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'A description about the list goes here.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    height: _showAllItems
                        ? (_networkImages.length * 150.0)
                        : (5 * 150.0 + 50.0),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          _showAllItems ? _networkImages.length + 1 : 5 + 1,
                      itemBuilder: (context, index) {
                        if (index == 5 && !_showAllItems) {
                          return TextButton(
                            onPressed: () {
                              setState(() {
                                _showAllItems = true;
                              });
                            },
                            child: Text('Show More'),
                          );
                        } else if (index == _networkImages.length &&
                            _showAllItems) {
                          return TextButton(
                            onPressed: () {
                              setState(() {
                                _showAllItems = false;
                              });
                            },
                            child: Text('Show Less'),
                          );
                        } else {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    _networkImages[index]['image']!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _networkImages[index]['title']!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Row(
                                        children: [
                                          Icon(Icons.description),
                                          SizedBox(width: 4.0),
                                          Expanded(
                                            child: Text(
                                              _networkImages[index]
                                                  ['description']!,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.0),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text('Button'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
