import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mcqpage extends StatefulWidget {
  final List<Map<String, dynamic>> randomelements;
  final int setnumber;
  const Mcqpage(
      {super.key, required this.randomelements, required this.setnumber});

  @override
  State<Mcqpage> createState() => _McqpageState();
}

class _McqpageState extends State<Mcqpage> {
  Map<int, String> selectedanswer = {};
  final ScrollController autoscroll = ScrollController();
  List<GlobalKey> questionKeys = [];

  @override
  void initState() {
    super.initState();
    loadSavedAnswers();
    questionKeys =
        List.generate(widget.randomelements.length, (index) => GlobalKey());
  }

  @override
  void dispose() {
    autoscroll.dispose();
    super.dispose();
  }

  void loadSavedAnswers() async {
    final prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < widget.randomelements.length; i++) {
      final question = widget.randomelements[i];
      final id = question['id'];

      String key = 'set_${widget.setnumber}_QN_$id';
      String? savedAnswer = prefs.getString(key);

      if (savedAnswer != null) {
        setState(() {
          selectedanswer[i] = savedAnswer;
        });
      }
    }
  }

  void scrollToNextQuestion(int currentIndex) {
    if (currentIndex + 1 < questionKeys.length) {
      final keyContext = questionKeys[currentIndex + 1].currentContext;
      if (keyContext != null) {
        Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void printSelectedAnswers() {
    log('${widget.setnumber}');
    for (var entry in selectedanswer.entries) {
      log('When ${widget.setnumber} Question ${entry.key + 1}: Answer: ${entry.value}');
    }
  }

  void loadAllAnswers() async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the JSON string from SharedPreferences
    String? answersJson = prefs.getString('set_${widget.setnumber}_answers');

    if (answersJson != null) {
      // Decode the JSON string back into a map
      Map<String, dynamic> answersMap = jsonDecode(answersJson);

      // Display the loaded answers
      log('Loaded answers for set ${widget.setnumber}: $answersMap');
      // Optionally, update the state with the loaded answers
      setState(() {
        selectedanswer =
            answersMap.map((key, value) => MapEntry(int.parse(key), value));
      });
    } else {
      log('No answers found for set ${widget.setnumber}');
    }
  }

  void saveAllAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    //used package
    HtmlUnescape unescape = HtmlUnescape();

    //firstly sanitilze the html tags here
    Map<String, dynamic> decodedans = selectedanswer.map((key, value) {
      return MapEntry(key.toString(), unescape.convert(value));
    });

    // Convert the selected answers map to a JSON string
    String answersJson = jsonEncode(decodedans);

    // Store the JSON string in SharedPreferences under a single key
    await prefs.setString('set_${widget.setnumber}_answers', answersJson);

    log('All answers saved under: set_${widget.setnumber}_answers');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Questions',
          style: TextStyle(fontSize: 15.sp),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.print),
              onPressed: () {
                printSelectedAnswers();
                saveAllAnswers();
              }),
          SizedBox(
            height: 25.h,
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: loadAllAnswers,
            child: Icon(Icons.visibility),
          )
        ],
      ),
      body: ListView.builder(
        controller: autoscroll,
        itemCount: widget.randomelements.length,
        itemBuilder: (context, index) {
          final question = widget.randomelements[index];
          final id = question['id'];
          final body = question['body'];
          final answers = question['answers'] as List;
          return SizedBox(
            key:
                questionKeys[index], // Assign the key to the question container
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.all(12.r),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${index + 1}. ',
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            Expanded(child: Html(data: body)),
                          ],
                        )),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'Answers:',
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    for (var ans in answers)
                      InkWell(
                          onTap: () async {
                            setState(() {
                              selectedanswer[index] = ans['answer'] as String;
                            });

                            log('${widget.setnumber}');

                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString(
                                'set_${widget.setnumber}_QN_$id',
                                selectedanswer[index]!);

                            // Scroll to the next question
                            scrollToNextQuestion(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(border: Border.all()),
                                child: Html(data: ans['answer'] as String)),
                          )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
