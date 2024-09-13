import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  bool unattended = false;
  void _loadSavedAnswer() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < widget.randomelements.length; i++) {
      final id = widget.randomelements[i]['id'];
      final answer = prefs.getString('set_${widget.setnumber}_QN_$id');
      if (answer != null) {
        selectedans[i] = answer;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<int> unattendedQuestions = widget.randomelements
        .asMap()
        .entries
        .where((entry) => !widget.attemptedQuestions.contains(entry.key))
        .map((entry) => entry.key)
        .toList();
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Review',
        style: TextStyle(fontSize: 15.sp),
      )
          ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        all = true;
                        attended = false;
                        unattended = false;
                      });
                    },
                    child: const Text('All')),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      setState(() {
                        all = false;
                        attended = true;
                        unattended = false;
                      });
                    },
                    child: const Text('Attended')),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      setState(() {
                        all = false;
                        attended = false;
                        unattended = true;
                      });
                    },
                    child: const Text('UnAttended'))
              ],
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, childAspectRatio: 1.5),
                itemCount: all
                    ? widget.randomelements.length
                    : attended
                        ? widget.attemptedQuestions.length
                        : unattendedQuestions.length,
                itemBuilder: (context, index) {
                  int? qnindex;
                  if (all) {
                    qnindex = index;
                  } else if (attended) {
                    qnindex = widget.attemptedQuestions[index];
                  } else {
                    qnindex = unattendedQuestions[index];
                    // int count = 0;
                    // for (var i = 0; i < widget.randomelements.length; i++) {
                    //   if (count == index) {
                    //     qnindex = 1;
                    //     break;
                    //   }
                    //   count++;
                    // }
                    // List<Map<String, dynamic>> unattemptedQuestions = widget
                    //     .randomelements
                    //     .where((question) => !widget.attemptedQuestions
                    //         .contains(widget.randomelements.indexOf(question)))
                    //     .toList();

                    // final question = unattemptedQuestions[index];
                  }
                  final question = widget.randomelements[qnindex!];
                  final id = question['id'];
                  final body = question['body'];
                  final answers = question['answers'] as List;
                  final questionnumber = qnindex + 1;
                  return Padding(
                    padding: EdgeInsets.all(8.0.r),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context, qnindex);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: widget.attemptedQuestions.contains(qnindex)
                              ? Border.all()
                              : null,
                          color: widget.attemptedQuestions.contains(qnindex)
                              // ? const Color.fromARGB(255, 225, 222, 222)
                              ? Colors.blue[500]
                              : const Color.fromARGB(255, 239, 238, 238),
                        ),
                        child: Center(
                          child: Text('$questionnumber',
                              style: widget.attemptedQuestions.contains(qnindex)
                                  ? const TextStyle(fontWeight: FontWeight.bold)
                                  : null),
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
