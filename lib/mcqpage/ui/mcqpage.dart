import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import 'package:mmccqq/homepage/bloc/home_bloc.dart';
import 'package:mmccqq/mcqpage/ui/check.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Mcqpage extends StatefulWidget {
  final List<Map<String, dynamic>> randomelements;
  final int setnumber;
  const Mcqpage(
      {super.key, required this.randomelements, required this.setnumber});

  @override
  State<Mcqpage> createState() => _McqpageState();
}

class _McqpageState extends State<Mcqpage> with TickerProviderStateMixin {
  //need to provide the ticker mixin
  Map<int, String> selectedanswer = {}; //saves all the selected answers here
  Timer? timer;
  Duration duration = const Duration(seconds: 10); // Default timer duration
  int countdown = 0;
  final ItemScrollController autoscroll = ItemScrollController();
  late final AnimationController blinkcontroller;
  bool isTimerRunning = true; //to make page static after timer runs out
  List<int> attmepted = [];
  @override
  void initState() {
    super.initState();
    startTimer();
    blinkcontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(); //repeative blinking
    // loadSavedAnswers();//saves all the answers
    // Listen to the item positions to get the current index
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (duration.inSeconds <= 0) {
        isTimerRunning = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Time is Finished'),
          duration: Duration(seconds: 1),
        ));
        saveAllAnswers();
        timer.cancel();
         setState(() {
          countdown = 0;
        });
        final bool timesup = await timefinished() ?? false;
        if (context.mounted && timesup) {
          Navigator.pop(context);
        }
       
      } else {
        setState(() {
          countdown = duration.inSeconds;
          duration = duration - const Duration(seconds: 1);
        });
      }
    });
  }
Future<bool?> timefinished() {
    return showDialog(
      context: context,
      barrierDismissible: false,//prevent the dialog from being dismissed when tapped outside the dialog box
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: Text(
              "Time's Up",
              style: TextStyle(fontSize: 18.sp),
            ),
            content: SizedBox(
              height: 80.h,
              child: Column(
                children: [
                  Text('Attended Qns ${selectedanswer.keys.length}'),
                  Text(
                      'Attended Qns ${widget.randomelements.length - selectedanswer.keys.length}'),
                ],
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () => Navigator.pop(context, true),
                child: Container(
                  width: 250.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Center(
                    child: Text(
                      'Ok',
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
  Future<void> clearSavedAnswers() async {
    final prefs = await SharedPreferences.getInstance();

    // Remove all saved answers for the current set
    // await prefs.remove('set_${widget.setnumber}_answers');

    // Optionally, you can also clear individual questions
    for (var element in widget.randomelements) {
      final id = element['id'];
      await prefs.remove('set_${widget.setnumber}_QN_$id');
    }

    log('All answers for set ${widget.setnumber} have been cleared.');
  }

  @override
  void dispose() {
    timer?.cancel();
    blinkcontroller.dispose();
    super.dispose();
  }

  void saveAllAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    HtmlUnescape unescape = HtmlUnescape();

    // Save selected answers
    Map<String, dynamic> decodedAnswers = selectedanswer.map((key, value) {
      return MapEntry(key.toString(), unescape.convert(value));
    });
    String answersJson = jsonEncode(decodedAnswers);
    await prefs.setString('set_${widget.setnumber}_answers', answersJson);

    // Save the entire set of questions
    List<Map<String, dynamic>> questions = widget.randomelements;
    String questionsJson = jsonEncode(questions);
    await prefs.setString('set_${widget.setnumber}_questions', questionsJson);

    log('All answers and questions saved for set ${widget.setnumber}');
  }

  

  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: SizedBox(
            height: 80.h,
            child: Column(
              children: [
                const Text(
                  'Are you sure you want to Submit this answers?',
                ),
                Text('Attended Qns(${selectedanswer.keys.length})'),
                Text(
                    'UnAttended Qns(${widget.randomelements.length - selectedanswer.keys.length})'),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            GestureDetector(
              onTap: () => Navigator.pop(context, false),
              child: Container(
                width: 128.w,
                height: 40.h,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(15.r)),
                child: const Center(child: Text('Cancel')),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context, true),
              child: Container(
                width: 128.w,
                height: 40.h,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(15.r)),
                child: const Center(child: Text('Submit')),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('HH:mm:ss')
        .format(DateTime(0).add(Duration(seconds: countdown)));
    bool isBlinking = countdown <= 60 && countdown > 0;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        await clearSavedAnswers();
        if (didPop) {
          return;
        }
        final bool shouldpop = await _showBackDialog() ?? false;

        if (context.mounted && shouldpop) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Set ${widget.setnumber}',
                  style: TextStyle(fontSize: 15.sp),
                ),
                AnimatedBuilder(
                    animation: blinkcontroller,
                    builder: (context, child) {
                      return Opacity(
                          opacity: isBlinking ? blinkcontroller.value : 1.0,
                          child: Text(
                            formattedTime,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: countdown <= 60
                                    ? Colors.red
                                    : Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.color),
                          ));
                    }),
                GestureDetector(
                  onTap: () async {
                    /// The line `List<int> attemptedQuestions = selectedanswer.keys.toList();` is
                    /// creating a new list `attemptedQuestions` that contains all the keys from the
                    /// `selectedanswer` map converted to a list of integers.
                    List<int> attemptedQuestions = selectedanswer.keys.toList();
                    context.read<HomeBloc>().add(ReviewEvent(
                          randomelements: widget.randomelements,
                          setnumber: widget.setnumber,
                        ));

                    final selectedQuestion = await showModalBottomSheet<int>(
                      context: context,
                      enableDrag: true,
                      isScrollControlled:
                          true, //this allows the model to take the custom height
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 0.7,
                          child: SizedBox(
                            child: Checking(
                              randomelements: widget.randomelements,
                              setnumber: widget.setnumber,
                              attemptedQuestions: attemptedQuestions,
                            ),
                          ),
                        );
                      },
                    );
                    if (selectedQuestion != null) {
                      // autoscroll.scrollTo(
                      //     index: selectedQuestion, //then, only get the index
                      //     duration: const Duration(seconds: 1));
                      autoscroll.jumpTo(index: selectedQuestion);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: Container(
                      width: 55.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                              width: 2.w,
                              color: const Color.fromARGB(255, 200, 199, 199))),
                      child: Center(
                        child: Text(
                          '${selectedanswer.length}/ ${widget.randomelements.length}',
                          style:
                              TextStyle(color: Colors.black, fontSize: 15.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: SizedBox(
            width: 65.w,
            child: FloatingActionButton(
              backgroundColor: Colors.blueAccent,
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                final bool shouldsubmit = await _showBackDialog() ?? false;
                if (context.mounted && shouldsubmit) {
                  saveAllAnswers();
                  Navigator.pop(context);
                }
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(15.r),
            child: ScrollablePositionedList.builder(
                itemScrollController: autoscroll,
                itemBuilder: (context, index) {
                  final question = widget.randomelements[index];
                  final id = question['id'];
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
                          GestureDetector(
                            onTap: isTimerRunning
                                ? () async {
                                    //
                                    setState(() {
                                      selectedanswer[index] = ans['answer'];
                                    });
                                    if (index + 1 <
                                        widget.randomelements.length) {
                                      autoscroll.jumpTo(index: index + 1);
                                    }
                                    // autoscroll.scrollTo(
                                    //     index: index + 1,
                                    //     duration:
                                    //         const Duration(milliseconds: 350));
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setString(
                                        'set_${widget.setnumber}_QN_$id',
                                        selectedanswer[index]!);
                                  }
                                : null,
                            child: Container(
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
                            ),
                          )
                      ],
                    ),
                  );
                },
                itemCount: widget.randomelements.length),
          )),
    );
  }
}
