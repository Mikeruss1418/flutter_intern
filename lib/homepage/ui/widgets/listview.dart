import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Listview extends StatelessWidget {
  final Function() onTap;
  final String text;
  final int index;
  const Listview(
      {super.key,
      required this.onTap,
      required this.text,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 0,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: ListTile(
          enableFeedback: true,
          selectedColor: Colors.black,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
          tileColor: Colors.grey[0],
          onTap: onTap,
          //  () {
          //   context.read<HomeBloc>().add(LoadRandomMCqEvent(
          //       mcqs: testList, setnumber: index + 1));
          // },
          title: Text(
            'Practice-Set ${index + 1}',
            style: TextStyle(fontSize: 19.sp),
          ),
          
          trailing: SizedBox(
            height: 35.h,
            width: 65.w,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r)),
              color: Colors.black,
              elevation: 5,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 15.sp, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
