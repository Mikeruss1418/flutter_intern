import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmccqq/mcqpage/bloc/mcq_bloc.dart';
import 'package:mmccqq/mcqpage/widgets/dialog_box.dart';
import 'package:mmccqq/mcqpage/widgets/qnscount.dart';
import 'package:mmccqq/mcqpage/widgets/questions.dart';
import 'package:mmccqq/mcqpage/widgets/submitbtn.dart';
import 'package:mmccqq/mcqpage/widgets/timercount.dart';
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
  final ScrollController control = ScrollController();
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

//lazy loading
  int loadbatch = 20; //each batch size
  int currentmaxindex = 20; // intial load
  bool isLoading = false; //checking if the there is loading needed


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
        countdown.value = 0; //current value stored in the countdown here.
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

  Future<void> loadmore() async {
    if (!isLoading && currentmaxindex < widget.randomelements.length) {//checkes if the data is already loading or not//if true loading more data
      setState(() {
        isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        currentmaxindex += loadbatch;//adds another batch of 20 items
        if (currentmaxindex > widget.randomelements.length) {
          currentmaxindex = widget.randomelements.length;
        }
        isLoading = false;
      });
    }
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
              Timercount(
                  countdown: countdown,
                  blinkcontroller: blinkcontroller,
                  isBlinking: isBlinking),
              Qnscount(
                  selectedanswer: selectedanswer,
                  widget: widget,
                  autoscroll: autoscroll),
            ],
          ),
        ),
        floatingActionButton: Submitbtn(
            showdialogbox: showdialogbox,
            selectedanswer: selectedanswer,
            widget: widget),
        body:

            /// This code snippet is using a `NotificationListener` widget in Flutter to listen for scroll
            /// notifications in a scrollable widget.
            //This code listens to scroll notifications 
            //and checks if the user has scrolled to
            // the bottom of the scrolling widget.
            // If they have, and the app is
            // not currently loading more data,
            // it calls a function to load more data.
            NotificationListener<ScrollNotification>(
          //listens to notification send by it's child.
          //Scrollnotification is notification sent by the scrolling widget(all scrollable widgets)
          onNotification: (notification) {//callback fn that is called when scrollnotification is received
            if (notification.metrics.pixels ==
                    notification.metrics.maxScrollExtent &&
                !isLoading) {//checks if scolling has reached the bottom of the screen(position at it's max. extend) also checks the falg here
              loadmore();
              return true;
            }
            return false;
          },
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: ScrollablePositionedList.builder(
              minCacheExtent: 20000,
              itemScrollController: autoscroll,
              itemBuilder: (context, index) {
                final question = widget.randomelements[index];
                final id = question['id'];
                final body = question['body'];
                final answers = question['answers'] as List;
                if (index == currentmaxindex &&
                    currentmaxindex < widget.randomelements.length) {
                  return Padding(
                    padding: EdgeInsets.all(20.r),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else if (index >= widget.randomelements.length) {
                  return const SizedBox();
                }
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
                            child: Question(
                              body: body,
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
                                  // log('set_${widget.setnumber}_QN_$id');
                                  //autoscrolling
                                  if (index + 1 <
                                      widget.randomelements.length) {
                                    autoscroll.scrollTo(
                                        index: index + 1,
                                        duration:
                                            const Duration(milliseconds: 500));
                                    // autoscroll.jumpTo(index: index + 1);
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
                        ),
                    ],
                  ),
                );
              },
              // itemCount: widget.randomelements.length
              itemCount: currentmaxindex < widget.randomelements.length
                  ? currentmaxindex + 1
                  : widget.randomelements.length,
            ),
          ),
        ),
      ),
    );
  }
}
