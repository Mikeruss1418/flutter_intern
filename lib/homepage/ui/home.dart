import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmccqq/homepage/Datas/test_dummy_data.dart';
// import 'package:mmccqq/homepage/ui/mcqpage.dart';
import 'package:mmccqq/homepage/ui/setlist.dart';

import '../../mcqpage/ui/mcqpage.dart';
import '../bloc/home_bloc.dart';
// import '../bloc/home_state.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  //for passing random elements

  // List<Map<String, dynamic>> getRandomElements() {
  //   final random = Random();
  //   List<Map<String, dynamic>> randommcq = List.from(testList)..shuffle(random);
  //   return randommcq.take(5).toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'MCQ',
              style: TextStyle(fontSize: 25.sp),
            ),
            InkWell(
              child: const Icon(Icons.menu),
              onTap: () {
                // log('width :${MediaQuery.of(context).size.width}');
                // log('height :${MediaQuery.of(context).size.height}');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Setlist()));
              },
            ),
          ],
        ),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == HomeState.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
              ),
            );
          }
          if (state.status == HomeStatus.loaded) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Mcqpage(
                    randomelements: state.randomMcqs!,
                    setnumber: state.setnumber!,
                  ),
                ));
          }
        },
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10.r),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r)),
                    tileColor: const Color.fromARGB(255, 228, 230, 231),
                    onTap: () {
                      context.read<HomeBloc>().add(LoadRandomMCqEvent(
                          mcqs: testList, setnumber: index + 1));
                    },
                    leading: Text(
                      '${index + 1}',
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    title: Text(
                      'Set ${index + 1}',
                      style: TextStyle(fontSize: 19.sp),
                    ),
                    trailing: SizedBox(
                      height: 35.h,
                      width: 65.w,
                      child: Card(
                        // shape: const RoundedRectangleBorder(),
                        color: Colors.black,
                        elevation: 5,
                        child: Center(
                          child: Text(
                            'Start!!',
                            style:
                                TextStyle(fontSize: 15.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
