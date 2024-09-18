import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmccqq/mcqpage/ui/check.dart';
import 'package:mmccqq/mcqpage/ui/mcqpage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Qnscount extends StatelessWidget {
  const Qnscount({
    super.key,
    required this.selectedanswer,
    required this.widget,
    required this.autoscroll,
  });

  final Map<int, String> selectedanswer;
  final Mcqpage widget;
  final ItemScrollController autoscroll;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
    );
  }
}