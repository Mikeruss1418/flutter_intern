import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Title'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            primary: true,
            expandedHeight: 100,
            backgroundColor: Colors
                .green, //this makes the color of title of Flexiblespacebar

            pinned:
                true, //wraps the title of the flexiblespacebar so that it doesn't scroll out of view when true
            floating:
                false, //makes the bacground to show atmoment scrolling upward if true.
            // title: Text('Title'),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(horizontal: 15),
              title: Text(
                'ScrollView',
                style: TextStyle(color: Colors.black),
              ),
              background: Container(
                width: double.infinity,
                height: 50,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.network(
                    'https://c8.alamy.com/comp/2CBYXT2/v-logo-valorant-shooter-game-symbol-vector-on-isolated-white-background-eps-10-2CBYXT2.jpg',
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 20,
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        size: 40,
                      ),
                      title: Text('Person ${index + 1}'),
                      subtitle: Text('Phone No...'),
                      trailing: Icon(Icons.more_vert_sharp),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(//this sliver is used to insert any kind of custom widget inside the customScrollview
            //READ
            child: SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('ListView.builder ${index + 1}'),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
