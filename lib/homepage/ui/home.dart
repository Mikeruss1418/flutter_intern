import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmccqq/homepage/Datas/test_dummy_data.dart';
import 'package:mmccqq/homepage/ui/mcqpage.dart';
import 'package:mmccqq/homepage/ui/savedpages.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              child: Icon(Icons.menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SavedAnswersPage(),
                    ));
              },
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.print),
      //   onPressed: () async {
      //     final prefs = await SharedPreferences.getInstance();
      //     // for(int i=0;)
      //   },
      // ),
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
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(15.r),
                child: Container(
                  // padding: EdgeInsets.all(15.r),
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(border: Border.all()),
                  child: ListTile(
                    onTap: () {
                      context.read<HomeBloc>().add(LoadRandomMCqEvent(
                          mcqs: testList, setnumber: index + 1));
                    },
                    leading: Text(
                      '${index + 1}',
                      style: TextStyle(fontSize: 13.sp),
                    ),
                    title: Text(
                      'Set ${index + 1}',
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    trailing: Icon(
                      Icons.question_answer,
                      size: 20.r,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
