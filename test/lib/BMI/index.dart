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
      title: 'BMI',
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
  var weight = TextEditingController();
  var height_in_feets = TextEditingController();
  var height_in_inches = TextEditingController();

  var result = ' ';

  @override
  Widget build(BuildContext context) {
    TextStyle txtstyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: _appbar(),
      body: Column(
        children: [
          txt(txtstyle, 'Weights in Kgs'),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: textfield('Enter your current Weight', weight),
          ),
          txt(txtstyle, 'Heights in Feets'),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: textfield('Enter your  current Height', height_in_feets),
          ),
          txt(txtstyle, "Heights in Inches"),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: textfield('Enter your current Height', height_in_inches),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            width: 100,
            child: FloatingActionButton(
              onPressed: () {
                var wt = weight.text.toString();
                var hf = height_in_feets.text.toString();
                var hi = height_in_inches.text.toString();

                if (wt.isEmpty || hf.isEmpty || hi.isEmpty) {
                  setState(() {
                    result = 'Please enter all the details';
                  });
                } else {
                  var iwt = double.parse(wt);
                  var ihf = double.parse(hf);
                  var ihi = double.parse(hi);
                  var bmi = iwt / (ihf * ihf);
                  setState(() {
                    result = 'Your BMI is $bmi';
                  });
                }

                //var bmi = wt / (hf * hf);
              },
              child: Text('Calculate'),
            ),
          ),
          Text(result),
        ],
      ),
    );
  }

  Container txt(TextStyle txtstyle, txt) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: Text(
          txt,
          style: txtstyle,
        ),
      ),
    );
  }

  TextField textfield(labelText, controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 2, color: Color.fromARGB(255, 141, 87, 177)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        labelText: labelText,
        prefixIcon: FaIcon(FontAwesomeIcons.weightScale),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: Center(
        child: Text('BMI'),
      ),
      backgroundColor: Colors.blue[700],
      toolbarHeight: 50,
    );
  }
}
