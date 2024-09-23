import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/presentation/blocs/movie_tab/movie_tab_bloc.dart';
import 'package:movie_app/presentation/journeys/home/movie_tab/movie_listview.dart';
import 'package:movie_app/presentation/journeys/home/movie_tab/movie_tabconstant.dart';
import 'package:movie_app/presentation/journeys/home/movie_tab/tab_title.dart';
import 'package:movie_app/presentation/widgets/movie_app_bar.dart';

class MovieTab extends StatefulWidget {
  const MovieTab({super.key});

  @override
  State<MovieTab> createState() => _MovieTabState();
}

class _MovieTabState extends State<MovieTab>
    with SingleTickerProviderStateMixin {
  MovieTabBloc get movietabbloc => BlocProvider.of<MovieTabBloc>(context);
  int currentindex = 0;

  @override
  void initState() {
    super.initState();
    movietabbloc.add(MovieTabChangedEvent(currentindex: currentindex));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTapped(int index) {
    movietabbloc.add(MovieTabChangedEvent(currentindex: index));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTabBloc, MovieTabState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: Sizes.dimen_4.h),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < MovieTabconstant.movietab.length; i++)
                    TabTitle(
                      title: MovieTabconstant.movietab[i].title,
                      onTap: () => _onTapped(i),
                      isSelected: MovieTabconstant.movietab[i].index ==
                          state.currentindex,
                    )
                ],
              ),
              if (state.status == MovieTabStatus.success)
                Expanded(
                  child: MovieListview(movies: state.movies!),
                )
            ],
          ),
        );
      },
    );
  }
}
