import 'package:day4/tabs/tab4.dart';
import 'package:flutter/material.dart';
import 'package:day4/tabs/tab2.dart';
import 'package:day4/tabs/tab3.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assesment 4',
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.purple,

          toolbarHeight: 150,
          title: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Assessment 4',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  Icon(Icons.add_link)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TabBar(
                tabs: [
                  Tab(
                    text: 'Day 2 Tab',
                  ),
                  Tab(
                    text: 'Day 3 Tab',
                  ),
                  Tab(
                    text: 'Day 4 Tab',
                  )
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Tabs2(),
            Tabs3(),
            Tabs4(),
          ],
        ),
      ),
    );
  }
}
