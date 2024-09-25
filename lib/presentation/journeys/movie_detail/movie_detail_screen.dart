import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/translation.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/dep_inj/get_it.dart';
import 'package:movie_app/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/presentation/journeys/movie_detail/cast_widget.dart';
import 'package:movie_app/presentation/journeys/movie_detail/movie_detail_args.dart';
import 'package:movie_app/presentation/journeys/movie_detail/poster.dart';
import 'package:movie_app/presentation/widgets/app_error_widgets.dart';

import '../../../common/constants/size_constants.dart';
import '../../blocs/cast/cast_bloc.dart';

class MovieDetailScrren extends StatefulWidget {
  const MovieDetailScrren({super.key, required this.movieDetailArgs})
      : assert(movieDetailArgs != null, 'Arguments cannot be null');
  final MovieDetailArgs movieDetailArgs;

  @override
  State<MovieDetailScrren> createState() => _MovieDetailScrrenState();
}

class _MovieDetailScrrenState extends State<MovieDetailScrren> {
  late MovieDetailBloc _movieDetailBloc;
  late CastBloc _castBloc;
  @override
  void initState() {
    super.initState();
    _movieDetailBloc = getit<MovieDetailBloc>();
    _castBloc = _movieDetailBloc.castBloc;
    _movieDetailBloc
        .add(MovieSelectedDetailEvent(widget.movieDetailArgs.movieId));
  }

  @override
  void dispose() {
    _movieDetailBloc.close();
    _castBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: _movieDetailBloc,
            ),
            BlocProvider.value(
              value: _castBloc,
            ),
          ],
          child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: (context, state) {
              if (state.status == MovieDetailStatus.success) {
                final moviedetail = state.moviedetail;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Poster(movie: moviedetail!),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Sizes.dimen_18.w),
                        child: Text(
                          moviedetail.overview!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
                        child: Text(
                          Translation.cast.t(context),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      CastWidget()
                    ],
                  ),
                );
              } else if (state.status == MovieDetailStatus.fail) {
                return ApperrorWidgets(
                  appErrorType: state.errorType!,
                  onPressed: () => _movieDetailBloc.add(
                      MovieSelectedDetailEvent(widget.movieDetailArgs.movieId)),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
