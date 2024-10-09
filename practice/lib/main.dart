import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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

String fname = '';
void addsaveInSharedP() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', fname);
}

class _HomeState extends State<Home> {
  var nameValue = ' No value saved';
  final TextEditingController name = TextEditingController();

  @override
  void initState() {
    super.initState();
    getloadInSharedP();
  }

  void getloadInSharedP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getname = prefs.getString('name');
    setState(() {});
    nameValue = getname ?? " No value saved";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: name,
          ),
          ElevatedButton(
              onPressed: () async {
                fname = name.text.toString();

                addsaveInSharedP();
              },
              child: const Text('Save')),
          const SizedBox(
            height: 10,
          ),
          Text(nameValue),
        ],
      ),
    );
  }
}
