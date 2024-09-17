import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mmccqq/mcqpage/bloc/mcq_bloc.dart';
import 'package:mmccqq/mcqpage/ui/check.dart';
import 'package:mmccqq/mcqpage/widgets/dialog_box.dart';
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
  final DialogBox showdialogbox = DialogBox();
  Timer? timer;
  Duration duration =
      const Duration(minutes: 30, seconds: 45); // Default timer duration
  ValueNotifier<int> countdown = ValueNotifier<int>(
      105); // Initially 1:45 in seconds//did this as it will directlt show 1.45
  // int countdown = 0;
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
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (duration.inSeconds <= 0) {
        isTimerRunning = false; //use to make the page static after time run out
        context.read<McqBloc>().add(SaveAllAnswerEvent(
            questions: widget.randomelements,
            answer: selectedanswer,
            setnumber: widget.setnumber));
        timer.cancel();
        countdown.value = 0;
        // setState(() {
        // });
        final bool timesup = await showdialogbox.timefinished(
                context,
                selectedanswer.keys.length,
                (widget.randomelements.length - selectedanswer.keys.length)) ??
            false;
        if (context.mounted && timesup) {
          Navigator.pop(context);
        }
      } else {
        countdown.value = duration.inSeconds;
        duration = duration - const Duration(seconds: 1);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    blinkcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isBlinking = countdown.value <= 60 && countdown.value > 0;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        context.read<McqBloc>().add(ClearSavedAnswersEvent(
            questions: widget.randomelements, setnumber: widget.setnumber));
        if (didPop) {
          return;
        }
        final bool shouldpop = await showdialogbox.showBackDialog(
                context,
                selectedanswer.keys.length,
                (widget.randomelements.length - selectedanswer.keys.length)) ??
            false;
        if (context.mounted && shouldpop) {
          context.read<McqBloc>().add(SaveAllAnswerEvent(
              questions: widget.randomelements,
              answer: selectedanswer,
              setnumber: widget.setnumber));
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Set ${widget.setnumber}',
                style: TextStyle(fontSize: 15.sp),
              ),
              ValueListenableBuilder<int>(
                  valueListenable: countdown,
                  builder: (context, value, child) {
                    String formattedTime = DateFormat('HH:mm:ss')
                        .format(DateTime(0).add(Duration(seconds: value)));
                    return AnimatedBuilder(
                      animation: blinkcontroller,
                      builder: (context, child) {
                        return Opacity(
                          opacity: isBlinking ? blinkcontroller.value : 1.0,
                          child: Text(
                            formattedTime,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: value <= 60
                                    ? Colors.red
                                    : Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.color),
                          ),
                        );
                      },
                    );
                  }),
              InkWell(
                onTap: () async {
                  List<int> attemptedQuestions = selectedanswer.keys.toList();
                  final selectedQuestion = await showModalBottomSheet<int>(
                    context: context,
                    enableDrag: true,
                    isScrollControlled:
                        true, //this allows the model to take the custom height
                    builder: (context) {
                      return FractionallySizedBox(
                        heightFactor: 0.7, //takes 70% of the screen
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
                    // autoscroll.jumpTo(index: selectedQuestion);
                    autoscroll.scrollTo(
                        index: selectedQuestion,
                        duration: const Duration(microseconds: 380));
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
                        style: TextStyle(color: Colors.black, fontSize: 15.sp),
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
              final bool shouldsubmit = await showdialogbox.showBackDialog(
                      context,
                      selectedanswer.keys.length,
                      (widget.randomelements.length -
                          selectedanswer.keys.length)) ??
                  false;
              if (context.mounted && shouldsubmit) {
                context.read<McqBloc>().add(SaveAllAnswerEvent(
                    questions: widget.randomelements,
                    answer: selectedanswer,
                    setnumber: widget.setnumber));
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.r),
          child: ScrollablePositionedList.builder(
              // physics: const BouncingScrollPhysics(),
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
                        InkWell(
                          onTap: isTimerRunning
                              ? () async {
                                  setState(() {
                                    selectedanswer[index] = ans['answer'];
                                  });
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString(
                                      'set_${widget.setnumber}_QN_$id',
                                      selectedanswer[index]!);
                                  print('set_${widget.setnumber}_QN_$id');
                                  //autoscrolling
                                  if (index + 1 <
                                      widget.randomelements.length) {
                                    autoscroll.jumpTo(index: index + 1);
                                  }
                                }
                              : null,
                          child: BlocBuilder<McqBloc, McqState>(
                            builder: (context, state) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 8.h),
                                decoration: BoxDecoration(
                                  border: selectedanswer[index] == ans['answer']
                                      ? Border.all()
                                      : null,
                                  color: selectedanswer[index] == ans['answer']
                                      ? const Color.fromARGB(255, 225, 222, 222)
                                      : const Color.fromARGB(
                                          255, 239, 238, 238),
                                ),
                                child: Html(
                                    data: ans['answer'] as String,
                                    style:
                                        selectedanswer[index] == ans['answer']
                                            ? {
                                                'body': Style(
                                                    fontSize: FontSize(16.sp),
                                                    fontWeight: FontWeight.bold)
                                              }
                                            : {}),
                              );
                            },
                          ),
                        )
                    ],
                  ),
                );
              },
              itemCount: widget.randomelements.length),
        ),
      ),
    );
  }
}
