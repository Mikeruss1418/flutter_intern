import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmccqq/mcqpage/bloc/mcq_bloc.dart';

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
    context.read<McqBloc>().add(LoadSavedAnswerEvent(
        setnumber: widget.setnumber, questions: widget.randomelements));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Review'),
      ),
      body:
       Padding(
        padding: EdgeInsets.all(20.r),
        child: ListView.builder(
          itemCount: widget.randomelements.length,
          itemBuilder: (context, index) {
            final question = widget.randomelements[index];
            final id = question['id'];
            final body = question['body'];
            final answers = question['answers'] as List;

            return 
            Padding(
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
                      SizedBox(width: 10.w),
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
                    'Answers:',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  for (var ans in answers)
                    BlocBuilder<McqBloc, McqState>(
                      builder: (context, state) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                            border:
                                state.selectedanswers[index] == ans['answer']
                                    ? Border.all()
                                    : null,
                            color: selectedans[index] == ans['answer']
                                ? const Color.fromARGB(255, 225, 222, 222)
                                : const Color.fromARGB(255, 239, 238, 238),
                          ),
                          child: Html(
                            data: ans['answer'] as String,
                            style: state.selectedanswers[index] == ans['answer']
                                ? {
                                    "body": Style(
                                        fontSize: FontSize(16.sp),
                                        fontWeight: FontWeight.bold)
                                  }
                                : {},
                          ),
                        );
                      },
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
