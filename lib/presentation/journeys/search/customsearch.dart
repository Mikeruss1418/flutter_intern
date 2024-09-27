import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/constants/translation.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/presentation/blocs/search/search_bloc.dart';
import 'package:movie_app/presentation/journeys/home/movie_tab/movie_tab_card.dart';
import 'package:movie_app/presentation/journeys/movie_detail/movie_detail_args.dart';
import 'package:movie_app/presentation/journeys/movie_detail/movie_detail_screen.dart';
import 'package:movie_app/presentation/themes/app_colors.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';
import 'package:movie_app/presentation/widgets/app_error_widgets.dart';

import '../../../common/constants/size_constants.dart';
import 'search_card.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchBloc searchbloc;

  CustomSearchDelegate(this.searchbloc);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context).textTheme.greySubtitle1,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: query.isEmpty ? Colors.grey : AppColors.royalblue,
        ),
        onPressed: query.isEmpty ? null : () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, null);
      },
      child: Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: Sizes.dimen_18.h,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchbloc.add(
      SearchTermChangedEvent(searchtxt: query),
    );

    return BlocBuilder<SearchBloc, SearchState>(
      bloc: searchbloc,
      builder: (context, state) {
        if (state.status == SearchStatus.error) {
          return ApperrorWidgets(
            appErrorType: state.errorType!,
            onPressed: () =>
                searchbloc.add(SearchTermChangedEvent(searchtxt: query)),
          );
        } else if (state.status == SearchStatus.success) {
          final movies = state.movies;
          if (movies!.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_64.w),
                child: Text(
                  Translation.noMoviesSearched.t(context),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 250.h,
                crossAxisSpacing: 25.w,
                mainAxisSpacing: 25.h),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MovieDetailScrren(
                        movieDetailArgs: MovieDetailArgs(movies[index].id)),
                  ));
                  log('movieId: ${movies[index].id}/n MovieTitle: ${movies[index].title}');
                },
                child: MovieTabCard(
                    movieId: movies[index].id,
                    title: movies[index].title,
                    posterpath: movies[index].posterpath),
              );
            },
            // SearchMovieCard(
            //   movie: movies[index],
            // ),
            itemCount: movies.length,
            // scrollDirection: Axis.horizontal,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
