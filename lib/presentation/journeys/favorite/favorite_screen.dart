import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/dep_inj/get_it.dart';
import 'package:movie_app/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:movie_app/presentation/journeys/favorite/favorite_movie_grid.dart';
import 'package:movie_app/presentation/journeys/watch_trailer/watch_trailer_screen.dart';

import '../../../common/constants/translation.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteBloc _favoriteBloc;
  @override
  void initState() {
    super.initState();
    _favoriteBloc = getit<FavoriteBloc>(); //initialization
    _favoriteBloc.add(LoadFavoriteEvent());
  }

  @override
  void dispose() {
    _favoriteBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 45.w),
          child: Text(
            Translation.favoriteMovies.t(context),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: BlocProvider.value(
          value: _favoriteBloc,
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state.status == FavoriteStatus.loaded) {
                if (state.movies!.isEmpty) {
                  return Center(
                    child: Text(
                      Translation.noFavoriteMovie.t(context),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                }
                return FavoriteMovieGrid(movies: state.movies!);
              }
              return const SizedBox.shrink();
            },
          )),
    );
  }
}
