import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmccqq/homepage/bloc/home_bloc.dart';
// import 'package:mmccqq/homepage/ui/mcqpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewScreen extends StatefulWidget {
  final List<Map<String, dynamic>> randomelements;
  final int setnumber;
  const ReviewScreen(
      {super.key, required this.randomelements, required this.setnumber});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  Map<int, String> selectedans = {};
  @override
  void initState() {
    super.initState();
    _loadSavedAnswers();
  }

  void _loadSavedAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < widget.randomelements.length; i++) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Review'),
      ),
      body: ListView.builder(
        itemCount: widget.randomelements.length,
        itemBuilder: (context, index) {
          final question = widget.randomelements[index];
          final id = question['id'];
          final body = question['body'];
          final answers = question['answers'] as List;

          return Padding(
            padding: EdgeInsets.all(12.r),
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
                                    fontWeight: FontWeight.bold)
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    'Answers:',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  for (var ans in answers)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 10.h),
                      child: Container(
                        decoration: BoxDecoration(
                          border: selectedans[index] == ans['answer']
                              ? Border.all()
                              : null,
                          color: selectedans[index] == ans['answer']
                              ? const Color.fromARGB(255, 225, 222, 222)
                              : const Color.fromARGB(255, 239, 238, 238),
                        ),
                        child: Html(
                          data: ans['answer'] as String,
                          style: selectedans[index] == ans['answer']
                              ? {
                                  "body": Style(
                                      fontSize: FontSize(15.sp),
                                      fontWeight: FontWeight.bold)
                                }
                              : {},
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
 