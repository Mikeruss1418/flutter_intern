import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmccqq/mcqpage/bloc/mcq_bloc.dart';
import 'package:mmccqq/mcqpage/ui/mcqpage.dart';
import 'package:mmccqq/mcqpage/widgets/dialog_box.dart';

class Submitbtn extends StatelessWidget {
  const Submitbtn({
    super.key,
    required this.showdialogbox,
    required this.selectedanswer,
    required this.widget,
  });

  final DialogBox showdialogbox;
  final Map<int, String> selectedanswer;
  final Mcqpage widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}