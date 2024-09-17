import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmccqq/blocobserver.dart';
import 'package:mmccqq/homepage/bloc/home_bloc.dart';
import 'package:mmccqq/homepage/ui/home.dart';
import 'package:mmccqq/mcqpage/bloc/mcq_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 872), //my screen size
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(),
          ),
          BlocProvider(create: (context) => McqBloc(),
          ),
        ],
        child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: Home()),
      ),
    );
  }
}
