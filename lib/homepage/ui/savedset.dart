import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Savedset extends StatefulWidget {
  final int setnumber;
  const Savedset({super.key, required this.setnumber});

  @override
  State<Savedset> createState() => _SavedsetState();
}

class _SavedsetState extends State<Savedset> {
  Map<int, String> selectedanswer = {};
  List<Map<String, dynamic>> questions = [];

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  Future<void> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();

    // Load selected answers
    String? answersJson = prefs.getString('set_${widget.setnumber}_answers');
    if (answersJson != null) {
      Map<String, dynamic> answersMap = jsonDecode(answersJson);
      setState(() {
        selectedanswer =
            answersMap.map((key, value) => MapEntry(int.parse(key), value));
      });
    }

    // Load questions
    String? questionsJson =
        prefs.getString('set_${widget.setnumber}_questions');
    if (questionsJson != null) {
      List<dynamic> questionsList = jsonDecode(questionsJson);
      setState(() {
        questions =
            questionsList.map((e) => e as Map<String, dynamic>).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Saved Answers for Set ${widget.setnumber}'),
      ),
      body:
       questions.isEmpty
          ? const Center(
              child: Text('No data Found here'),
            )
          : Padding(
              padding: EdgeInsets.all(20.r),
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  // final id = question['id'];
                  final body = question['body'];
                  final answers = question['answers'] as List;

                  return Padding(
                    padding: EdgeInsets.all(15.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${index + 1}.',
                              style: TextStyle(fontSize: 22.sp),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Html(
                                data: body,
                                style: {
                                  'body': Style(
                                      fontSize: FontSize(16.sp),
                                      fontWeight: FontWeight.bold)
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Answers',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        for (var ans in answers)
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8.h),
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
                                        'body': Style(
                                            fontSize: FontSize(16.sp),
                                            fontWeight: FontWeight.bold)
                                      }
                                    : {}),
                          )
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
