import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

class MovieData extends StatelessWidget {
  const MovieData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBackdropBloc, MovieBackdropState>(
      builder: (context, state) {
        if (state.status == MovieBackdropStatus.success) {
          return Text(
            state.movie!.title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.titleLarge,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
