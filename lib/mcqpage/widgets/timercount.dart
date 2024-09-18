import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class Timercount extends StatelessWidget {
  const Timercount({
    super.key,
    required this.countdown,
    required this.blinkcontroller,
    required this.isBlinking,
  });

  final ValueNotifier<int> countdown;
  final AnimationController blinkcontroller;
  final bool isBlinking;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: countdown,
        builder: (context, value, child) {
          String formattedTime = DateFormat('HH:mm:ss')
              .format(DateTime(0).add(Duration(seconds: value)));
          return AnimatedBuilder(
            animation: blinkcontroller,
            builder: (context, child) {
              return Opacity(
                opacity: isBlinking ? blinkcontroller.value : 1.0,
                child: Text(
                  formattedTime,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: value <= 60
                          ? Colors.red
                          : Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.color),
                ),
              );
            },
          );
        });
  }
}