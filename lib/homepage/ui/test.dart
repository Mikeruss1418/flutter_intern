// Mcqpage.dart

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import 'package:mmccqq/homepage/ui/check.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmccqq/homepage/bloc/home_bloc.dart';

class Mcqpage extends StatefulWidget {
  final List<Map<String, dynamic>> randomelements;
  final int setnumber;
  const Mcqpage({super.key, required this.randomelements, required this.setnumber});

  @override
  State<Mcqpage> createState() => _McqpageState();
}

class _McqpageState extends State<Mcqpage> {
  Map<int, String> selectedanswer = {};
  final ScrollController autoscroll = ScrollController();
  List<GlobalKey> questionKeys = [];
  int currentindex = 0;
  Duration duration = const Duration(minutes: 5); // for now default time
  Timer? timer;
  int countdowm = 0; // store current countdown

  @override
  void initState() {
    super.initState();
    starttimer();
    autoscroll.addListener(() {
      int index = (autoscroll.offset / (MediaQuery.of(context).size.height - kToolbarHeight)).round();
      if (index != currentindex) {
        setState(() {
          currentindex = index;
        });
      }
    });

    questionKeys = List.generate(widget.randomelements.length, (index) => GlobalKey());
  }

  Future<void> clearSavedAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('set_${widget.setnumber}_answers');

    for (var element in widget.randomelements) {
      final id = element['id'];
      await prefs.remove('set_${widget.setnumber}_QN_$id');
    }

    log('All answers for set ${widget.setnumber} have been cleared.');
  }

  void starttimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (duration.inSeconds <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Time is Finished'),
          duration: Duration(seconds: 1),
        ));
        saveAllAnswers();
        timer.cancel();
        setState(() {
          countdowm = 0;
        });
      } else {
        setState(() {
          countdowm = duration.inSeconds;
          duration = duration - const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    autoscroll.dispose();
    super.dispose();
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

  void saveAllAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    HtmlUnescape unescape = HtmlUnescape();
    Map<String, dynamic> decodedans = selectedanswer.map((key, value) {
      return MapEntry(key.toString(), unescape.convert(value));
    });
    String answersJson = jsonEncode(decodedans);
    await prefs.setString('set_${widget.setnumber}_answers', answersJson);
    log('All answers saved under: set_${widget.setnumber}_answers');
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('mm:ss').format(DateTime(0).add(Duration(seconds: countdowm)));
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PracticeSet ${widget.setnumber}',
              style: TextStyle(fontSize: 15.sp),
            ),
            Text('$formattedTime'),
            ElevatedButton(
              onPressed: () {
                List<int> attemptedQuestions = selectedanswer.keys.toList();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Checking(
                      randomelements: widget.randomelements,
                      setnumber: widget.setnumber,
                      attemptedQuestions: attemptedQuestions, // Pass attempted questions
                    ),
                  ),
                );
              },
              child: Text('${currentindex + 1}/${widget.randomelements.length}')
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.print),
        onPressed: () {
          saveAllAnswers();
        }
      ),
      body: ListView.builder(
        shrinkWrap: true,
        controller: autoscroll,
        itemCount: widget.randomelements.length,
        itemBuilder: (context, index) {
          final question = widget.randomelements[index];
          final id = question['id'];
          final body = question['body'];
          final answers = question['answers'] as List;
          return SingleChildScrollView(
            child: SizedBox(
              key: questionKeys[index],
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: GestureDetector(
                  onTap: ()=>print('${index+1}'),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            padding: EdgeInsets.all(15.r),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${index + 1}. ',
                                  style: TextStyle(fontSize: 25.sp),
                                ),
                                Expanded(
                                  child: Html(
                                    data: body,
                                    style: {
                                      'body': Style(
                                        fontSize: FontSize(15.sp),
                                        fontWeight: FontWeight.bold
                                      )
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
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
                              await prefs.setString('set_${widget.setnumber}_QN_$id', selectedanswer[index]!);
                              scrollToNextQuestion(index);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: selectedanswer[index] == ans['answer']
                                    ? Border.all()
                                    : null,
                                  color: selectedanswer[index] == ans['answer']
                                    ? const Color.fromARGB(255, 225, 222, 222)
                                    : const Color.fromARGB(255, 239, 238, 238),
                                ),
                                child: Html(
                                  data: ans['answer'] as String,
                                  style: selectedanswer[index] == ans['answer']
                                    ? {
                                        "body": Style(
                                          fontSize: FontSize(15.sp),
                                          fontWeight: FontWeight.bold
                                        )
                                      }
                                    : {},
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
