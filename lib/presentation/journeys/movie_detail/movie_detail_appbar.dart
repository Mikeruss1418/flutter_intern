import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/domain/entities/movie_detail_entity.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';

import '../../blocs/favorite/favorite_bloc.dart';

class MovieDetailAppBar extends StatefulWidget {
  final MovieDetailEntity movieDetailEntity;
  const MovieDetailAppBar({super.key, required this.movieDetailEntity});

  @override
  State<MovieDetailAppBar> createState() => _MovieDetailAppBarState();
}

class _MovieDetailAppBarState extends State<MovieDetailAppBar> {
  

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: Sizes.dimen_24.h,
          ),
        ),
        BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state.status == FavoriteStatus.isFavorite) {
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<FavoriteBloc>(context).add(
                      ToggleFavoriteEvent(
                          movieEntity: MovieEntity.fromMovieDetailEntity(
                              widget.movieDetailEntity),
                          isFavorite: state.isFavorite!));
                },
                child: Icon(
                  state.isFavorite!
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.white,
                  size: Sizes.dimen_24.h,
                ),
              );
            } else {
              return Icon(
                Icons.favorite_border_outlined,
                color: Colors.white,
                size: Sizes.dimen_24.h,
              );
            }
          },
        ),
      ],
    );
  }
}
