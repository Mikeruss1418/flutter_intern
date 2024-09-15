import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmccqq/mcqpage/ui/review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Checking extends StatefulWidget {
  final List<Map<String, dynamic>> randomelements;
  final int setnumber;
  final List<int> attemptedQuestions;
  const Checking(
      {super.key,
      required this.randomelements,
      required this.setnumber,
      required this.attemptedQuestions});

  @override
  State<Checking> createState() => _CheckingState();
}

class _CheckingState extends State<Checking> {
  Map<int, String> selectedans = {};
  bool all = false;
  bool attended = false;
  bool unattended = true;

  // void _loadSavedAnswer() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   for (int i = 0; i < widget.randomelements.length; i++) {
  //     final id = widget.randomelements[i]['id'];
  //     final answer = prefs.getString('set_${widget.setnumber}_QN_$id');
  //     if (answer != null) {
  //       selectedans[i] = answer;
  //     }
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    /// This code snippet is creating a list of indices representing the questions that have not been
    /// attempted yet. Here's a breakdown of what each part of the code is doing:
    List<int> unattendedQuestions = widget.randomelements
        .asMap() //convert list to map where each key is index of the element and the value is element itself
        .entries //returns an iterable of map entries,where each entry is a key-value pair.
        .where((entry) => !widget.attemptedQuestions.contains(entry.key))
        .map((entry) => entry.key)
        .toList();
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Review',
            style: TextStyle(fontSize: 15.sp),
          ),
          GestureDetector(
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewScreen(
                        randomelements: widget.randomelements,
                        setnumber: widget.setnumber),
                  )),
              child: const Icon(Icons.book_online_rounded))
        ],
      )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: all == true ? Colors.black : null),
                    onPressed: () {
                      setState(() {
                        all = true;
                        attended = false;
                        unattended = false;
                      });
                    },
                    child: Text(
                      'All(${widget.randomelements.length})',
                      style: TextStyle(
                          color: all == true ? Colors.white : Colors.black),
                    )),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            attended == true ? Colors.black : null),
                    onPressed: () {
                      setState(() {
                        all = false;
                        attended = true;
                        unattended = false;
                      });
                    },
                    child: Text(
                        'Attended (${widget.attemptedQuestions.length})',
                        style: TextStyle(
                            color: attended == true
                                ? Colors.white
                                : Colors.black))),
                TextButton(
                  style: unattended == true
                      ? TextButton.styleFrom(
                          backgroundColor:
                              unattended == true ? Colors.black : null)
                      : null,
                  onPressed: () {
                    setState(() {
                      all = false;
                      attended = false;
                      unattended = true;
                    });
                  },
                  child: Text(
                    'UnAttended (${unattendedQuestions.length})',
                    style: TextStyle(
                        color:
                            unattended == true ? Colors.white : Colors.black),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, childAspectRatio: 1.3),
                itemCount: all
                    ? widget.randomelements.length
                    : attended
                        ? widget.attemptedQuestions.length
                        : unattendedQuestions.length,
                itemBuilder: (context, index) {
                  //for index of the question
                  int? qnId;
                  if (all) {
                    qnId = widget.randomelements[index]['id'];
                  } else if (attended) {
                    qnId = widget
                        .randomelements[widget.attemptedQuestions[index]]['id'];
                  } else {
                    qnId =
                        widget.randomelements[unattendedQuestions[index]]['id'];
                  }
                  final question = widget.randomelements.indexWhere(
                    (element) => element['id'] == qnId,
                  );
                  //same parameters send as of review screen
                  //if needed
                  // final body = question['body'];
                  // final answers = question['answers'] as List;
                  // final id = question['id'];
                  return Padding(
                    padding: EdgeInsets.all(8.0.r),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(
                            context, question); //need to provide the index here
                      },
                      child: Container(
                        // width: 30.w,
                        // height: 30.h,
                        decoration: BoxDecoration(
                          border: widget.attemptedQuestions.contains(question)
                              ? Border.all(
                                  color:
                                      const Color.fromARGB(255, 200, 199, 199),
                                )
                              : Border.all(
                                  color:
                                      const Color.fromARGB(255, 200, 199, 199)),
                          borderRadius: BorderRadius.circular(8.r),
                          color: widget.attemptedQuestions.contains(question)
                              ? const Color.fromARGB(255, 225, 222, 222)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text('${question + 1}',
                              style: TextStyle(
                                  fontWeight: widget.attemptedQuestions
                                          .contains(question)
                                      ? FontWeight.bold
                                      : null,
                                  fontSize: 18.sp)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
