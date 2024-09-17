import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmccqq/homepage/ui/home.dart';
import 'package:mmccqq/mcqpage/widgets/dialogbutton.dart';
import 'package:mmccqq/mcqpage/widgets/dialogtxt.dart';

class DialogBox{
  Future<bool?> timefinished(BuildContext context,int attendedqns,int unattendedqns) {
    return showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent dismissing the dialog by tapping outside
      builder: (context) {
        return PopScope(
          canPop: false, // Prevent back button from dismissing the dialog
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Time's Up",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    Dialogtxt(
                      label: 'Attended Qns: ',
                      count: '$attendedqns',
                      color: Colors.green[700]!,
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      margin: EdgeInsets.only(left: 20.w),
                      child: Dialogtxt(
                        label: 'Unattended Qns: ',
                        count:
                            '$unattendedqns',
                        color:unattendedqns == 0 ? Colors.black : Colors.red[700]!,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    InkWell(
                      onTap: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ),
                        (route) =>
                            false, // Prevent returning to previous screens
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 45.h,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                            'Ok',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
   Future<bool?> showBackDialog(BuildContext context, int attendedqns, int unattendedqns) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: 5,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Are You Sure?',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Are you sure you want to submit the paper?',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Dialogtxt(
                        label: 'Attended Qns ',
                        count: '$attendedqns',
                        color: Colors.green[700]!,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.w),
                        child: Dialogtxt(
                          label: 'Unattended Qns ',
                          count:
                              '$unattendedqns',
                          color: unattendedqns == 0 ? Colors.black: Colors.red[700]!,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BuildDialogbtn(
                        text: 'Cancel',
                        onPressed: () => Navigator.pop(context, false),
                        isPrimary: false,
                      ),
                      BuildDialogbtn(
                        text: 'Submit',
                        onPressed: () => Navigator.pop(context, true),
                        isPrimary: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}