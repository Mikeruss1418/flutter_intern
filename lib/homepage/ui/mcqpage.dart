// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:html_unescape/html_unescape.dart';
// import 'package:intl/intl.dart';
// import 'package:mmccqq/homepage/bloc/home_bloc.dart';
// import 'package:mmccqq/homepage/ui/Review.dart';
// import 'package:mmccqq/homepage/ui/check.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Mcqpage extends StatefulWidget {
//   final List<Map<String, dynamic>> randomelements;
//   final int setnumber;
//   const Mcqpage(
//       {super.key, required this.randomelements, required this.setnumber});

//   @override
//   State<Mcqpage> createState() => _McqpageState();
// }

// class _McqpageState extends State<Mcqpage> {
//   Map<int, String> selectedanswer = {};
//   final ScrollController autoscroll = ScrollController();
//   int currentindex = 0;
//   Duration duration = const Duration(minutes: 5); //for now default time
//   Timer? timer;
//   int countdowm = 0; //store current countdown

//   @override
//   void initState() {
//     super.initState();
//     starttimer();
//     a

//   Future<void> clearSavedAnswers() async {
//     final prefs = await SharedPreferences.getInstance();

//     // Remove all saved answers for the current set
//     await prefs.remove('set_${widget.setnumber}_answers');

//     // Optionally, you can also clear individual questions
//     for (var element in widget.randomelements) {
//       final id = element['id'];
//       await prefs.remove('set_${widget.setnumber}_QN_$id');
//     }

//     log('All answers for set ${widget.setnumber} have been cleared.');
//   }

//   void starttimer() {
//     timer = Timer.periodic(
//       const Duration(seconds: 1),
//       (timer) {
//         if (duration.inSeconds <= 0) {
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text('Time is Finished'),
//             duration: Duration(seconds: 1),
//           ));
//           saveAllAnswers();
//           timer.cancel();
//           setState(() {
//             countdowm = 0;
//           });
//         } else {
//           //updating the value of countdown with each sec.
//           setState(() {
//             countdowm = duration.inSeconds;
//             duration = duration - const Duration(seconds: 1);
//           });
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     autoscroll.dispose();
//     super.dispose();
//   }

//   void scrollToNextQuestion(int currentIndex) {
//     if (currentIndex + 1 < questionKeys.length) {
//       final keyContext = questionKeys[currentIndex + 1].currentContext;
//       if (keyContext != null) {
//         Scrollable.ensureVisible(
//           keyContext,
//           duration: const Duration(seconds: 1),
//           curve: Curves.easeInOut,
//         );
//       }
//     }
//   }
// //

//   //method to handle scroll events
//   

//   ///needed
//   void saveAllAnswers() async {
//     final prefs = await SharedPreferences.getInstance();
//     //used package
//     HtmlUnescape unescape = HtmlUnescape();

//     //firstly sanitilze the html tags here
//     Map<String, dynamic> decodedans = selectedanswer.map((key, value) {
//       return MapEntry(key.toString(), unescape.convert(value));
//     });

//     // Convert the selected answers map to a JSON string
//     String answersJson = jsonEncode(decodedans);

//     // Store the JSON string in SharedPreferences under a single key
//     await prefs.setString('set_${widget.setnumber}_answers', answersJson);

//     log('All answers saved under: set_${widget.setnumber}_answers');
//   }

//   @override
//   Widget build(BuildContext context) {
//     String formattedTime = DateFormat('mm:ss')
//         .format(DateTime(0).add(Duration(seconds: countdowm)));
//     return PopScope(
//       canPop: true,
//       onPopInvokedWithResult: (didPop, result) async =>
//           await clearSavedAnswers(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'PracticeSet ${widget.setnumber}',
//                 style: TextStyle(fontSize: 15.sp),
//               ),
//               Text('$formattedTime'),
//               ElevatedButton(
//                   onPressed: () async {
//                     List<int> attemptedQuestions = selectedanswer.keys.toList();

//                     context.read<HomeBloc>().add(ReviewEvent(
//                         randomelements: widget.randomelements,
//                         setnumber: widget.setnumber));

//                     //show bottomshet model
//                     final selectedqn = await showModalBottomSheet<int>(
//                       context: context,
//                       builder: (context) {
//                         return Checking(
//                             randomelements: widget.randomelements,
//                             setnumber: widget.setnumber,
//                             attemptedQuestions: attemptedQuestions);
//                       },
//                     );
//                   },
//                   child: Text(
//                       '${currentindex + 1}/${widget.randomelements.length}'))
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//             child: const Icon(Icons.print),
//             onPressed: () {
//               saveAllAnswers();
//             }),
//         body: ListView.separated(
//           separatorBuilder: (context, index) => SizedBox(
//             height: 20.h,
//           ),
//           physics: const AlwaysScrollableScrollPhysics(),
//           // cacheExtent: 6000,
//           controller: autoscroll,
//           itemCount: widget.randomelements.length,
//           itemBuilder: (context, index) {
//             final question = widget.randomelements[index];
//             final id = question['id'];
//             final body = question['body'];
//             final answers = question['answers'] as List;
//             return SingleChildScrollView(
//               child: SizedBox(
//                 key: questionKeys[index],
//                 // Assign the key to the question container
//                 child: GestureDetector(
//                   onTap: () => print('${index + 1}'),
//                   child: Card(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                             width: MediaQuery.of(context).size.width,
//                             // decoration: BoxDecoration(border: Border.all()),
//                             child: Container(
//                               // color: const Color.fromARGB(255, 230, 230, 230),
//                               padding: EdgeInsets.all(15.r),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     '${index + 1}. ',
//                                     style: TextStyle(fontSize: 25.sp),
//                                   ),
//                                   Expanded(
//                                       child: Html(
//                                     data: body,
//                                     style: {
//                                       'body': Style(
//                                           fontSize: FontSize(15.sp),
//                                           fontWeight: FontWeight.bold)
//                                     },
//                                   )),
//                                 ],
//                               ),
//                             )),
//                         SizedBox(
//                           height: 15.h,
//                         ),
//                         Text(
//                           'Answers:',
//                           style: TextStyle(fontSize: 15.sp),
//                         ),
//                         for (var ans in answers)
//                           InkWell(
//                               onTap: () async {
//                                 setState(() {
//                                   selectedanswer[index] =
//                                       ans['answer'] as String;
//                                 });
//                                 // log('${widget.setnumber}');

//                                 final prefs =
//                                     await SharedPreferences.getInstance();
//                                 await prefs.setString(
//                                     'set_${widget.setnumber}_QN_$id',
//                                     selectedanswer[index]!);

//                                 // Scroll to the next question
//                                 scrollToNextQuestion(index);
//                               },
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 18.w, vertical: 10.h),
//                                 child: Container(
//                                     decoration: BoxDecoration(
//                                       border:
//                                           selectedanswer[index] == ans['answer']
//                                               ? Border.all()
//                                               : null,
//                                       color:
//                                           selectedanswer[index] == ans['answer']
//                                               ? const Color.fromARGB(
//                                                   255, 225, 222, 222)
//                                               : const Color.fromARGB(
//                                                   255, 239, 238, 238),
//                                     ),
//                                     child: Html(
//                                       data: ans['answer'] as String,
//                                       style: selectedanswer[index] ==
//                                               ans['answer']
//                                           ? {
//                                               "body": Style(
//                                                   fontSize: FontSize(15.sp),
//                                                   // color: Colors.amber,
//                                                   fontWeight: FontWeight.bold)
//                                             }
//                                           : {},
//                                     )),
//                               )),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import 'package:mmccqq/homepage/bloc/home_bloc.dart';
import 'package:mmccqq/homepage/ui/check.dart';
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

class _McqpageState extends State<Mcqpage> {
  Map<int, String> selectedanswer = {};
  Timer? timer;
  Duration duration = const Duration(minutes: 5); // Default timer duration
  int countdown = 0;
  final ScrollController autoscroll = ScrollController();

  @override
  void initState() {
    super.initState();
    startTimer();
    // loadSavedAnswers();//saves all the answers
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (duration.inSeconds <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Time is Finished'),
          duration: Duration(seconds: 1),
        ));
        saveAllAnswers();
        timer.cancel();
        setState(() {
          countdown = 0;
        });
      } else {
        setState(() {
          countdown = duration.inSeconds;
          duration = duration - const Duration(seconds: 1);
        });
      }
    });
  }
  Future<void> clearSavedAnswers() async {
    final prefs = await SharedPreferences.getInstance();

    // Remove all saved answers for the current set
    await prefs.remove('set_${widget.setnumber}_answers');

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
    autoscroll.dispose();
    super.dispose();
  }

  // Future<void> loadSavedAnswers() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final savedAnswers = prefs.getString('set_${widget.setnumber}_answers');
  //   if (savedAnswers != null) {
  //     setState(() {
  //       selectedAnswer = Map<int, String>.from(json.decode(savedAnswers));
  //     });
  //   }
  // }

  void saveAllAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    HtmlUnescape unescape = HtmlUnescape();
    Map<String, dynamic> decodedAnswers = selectedanswer.map((key, value) {
      return MapEntry(key.toString(), unescape.convert(value));
    });

    String answersJson = jsonEncode(decodedAnswers);
    await prefs.setString('set_${widget.setnumber}_answers', answersJson);
    log('All answers saved for set ${widget.setnumber}');
  }

  void scrollToNextQuestion(int currentindex) {
    if (currentindex + 1 < widget.randomelements.length) {
      final offset = autoscroll.position.maxScrollExtent *
          ((currentindex + 1) / widget.randomelements.length);
      autoscroll.animateTo(
        offset,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('mm:ss')
        .format(DateTime(0).add(Duration(seconds: countdown)));

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result)async => await clearSavedAnswers() ,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Practice Set ${widget.setnumber}',
                style: TextStyle(fontSize: 15.sp),
              ),
              Text('$formattedTime'),
              ElevatedButton(
                onPressed: () async {
                  List<int> attemptedQuestions = selectedanswer.keys.toList();
                  context.read<HomeBloc>().add(ReviewEvent(
                        randomelements: widget.randomelements,
                        setnumber: widget.setnumber,
                      ));
      
                  final selectedQuestion = await showModalBottomSheet<int>(
                    context: context,
                    builder: (context) {
                      return Checking(
                        randomelements: widget.randomelements,
                        setnumber: widget.setnumber,
                        attemptedQuestions: attemptedQuestions,
                      );
                    },
                  );
                },
                child: Text(
                    '${selectedanswer.length}/${widget.randomelements.length}'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            saveAllAnswers();
          },
        ),
        body: CustomScrollView(
          controller: autoscroll,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final question = widget.randomelements[index];
                  final id = question['id'];
                  final body = question['body'];
                  final answers = question['answers'] as List;
      
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(15.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${index + 1}. ',
                                  style: TextStyle(fontSize: 22.sp),
                                ),
                                Expanded(
                                  child: Html(
                                    data: body,
                                    style: {
                                      'body': Style(
                                        fontSize: FontSize(16.sp),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Answers:',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            for (var ans in answers)
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    selectedanswer[index] = ans['answer'];
                                  });
      
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString(
                                    'set_${widget.setnumber}_QN_$id',
                                    selectedanswer[index]!,
                                  );
      
                                  scrollToNextQuestion(index);
                                },
                                child: Container(
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
                                  padding: EdgeInsets.all(12.r),
                                  child: Html(
                                    data: ans['answer'] as String,
                                    style: selectedanswer[index] == ans['answer']
                                        ? {
                                            'body': Style(
                                              fontSize: FontSize(16.sp),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          }
                                        : {
                                            'body': Style(
                                              fontSize: FontSize(16.sp),
                                            ),
                                          },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: widget.randomelements.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//   List<GlobalKey> questionKeys = [];

///initstate
// autoscroll.addListener(_onScroll);
//     // loadSavedAnswers();//checks if for this set, if the answers have been answered or not?

//     /// The line `questionKeys = List.generate(widget.randomelements.length, (index) => GlobalKey());` is
//     /// generating a list of `GlobalKey` objects for each question in the `widget.randomelements` list.
//     questionKeys =
//         List.generate(widget.randomelements.length, (index) => GlobalKey());
//   }

// void _onScroll() {
//     for (int i = 0; i < questionKeys.length; i++) {
//       final keycontext = questionKeys[i].currentContext;
//       if (keycontext != null) {
//         final box = keycontext.findRenderObject() as RenderBox?;
//         if (box != null) {
//           final position = box.localToGlobal(Offset.zero);
//           if (position.dy >= 0 &&
//               position.dy < MediaQuery.of(context).size.height) {
//             if (i != currentindex) {
//               setState(() {
//                 currentindex = i;
//               });
//             }
//             break;
//           }
//         }
//       }
//     }
//   }