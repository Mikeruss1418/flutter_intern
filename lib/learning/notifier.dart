import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmccqq/homepage/ui/home.dart';

class Notifier extends StatelessWidget {
  const Notifier({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> count = ValueNotifier<bool>(true);//intial value

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifier',
          style: TextStyle(fontSize: 14.sp),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        count.value = !count.value;
      }),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: count,
          builder: (context, value, child) {
            return Text(
              'Count',
              style: TextStyle(fontSize: count.value == true ? 25.sp : 10.sp),
            );
          },
        ),
      ),
    );
  }
}
