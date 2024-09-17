import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmccqq/homepage/Datas/test_dummy_data.dart';
import 'package:mmccqq/homepage/ui/setlist.dart';
import 'package:mmccqq/homepage/ui/widgets/listview.dart';

import '../../mcqpage/ui/mcqpage.dart';
import '../bloc/home_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
                return Listview(
                    onTap: () {
                      context.read<HomeBloc>().add(LoadRandomMCqEvent(
                          mcqs: testList, setnumber: index + 1));
                    },
                    text: 'Start!!',
                    index: index);
              },
            ),
          );
        },
      ),
    );
  }
}
