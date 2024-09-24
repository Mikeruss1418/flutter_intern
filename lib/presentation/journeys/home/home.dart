import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/dep_inj/get_it.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_tab/movie_tab_bloc.dart';
import 'package:movie_app/presentation/journeys/drawer/naviagtion_drawer.dart';
import 'package:movie_app/presentation/widgets/app_error_widgets.dart';
import 'package:movie_app/presentation/journeys/home/movie_carousel/movie_carousel_widget.dart';
import 'package:movie_app/presentation/journeys/home/movie_tab/movie_tab.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MovieCarouselBloc movieCarouselBloc;
  late MovieBackdropBloc movieBackdropBloc;
  late MovieTabBloc movieTabBloc;
  @override
  void initState() {
    super.initState();
    movieCarouselBloc = getit<MovieCarouselBloc>();
    // movieBackdropBloc = getit<MovieBackdropBloc>();//this instance is different from carousel bloc found instance
    //to solve this there are 2 ways
    // - use if singleton in get it
    // -take the instance of moviebackdropbloc from movie carouselbloc like this
    movieBackdropBloc = movieCarouselBloc.movieBackdropBloc;
    movieTabBloc = getit<MovieTabBloc>();
    movieCarouselBloc.add(const CarouselLoadEvent());
  }

  @override
  void dispose() {
    movieCarouselBloc.close();
    movieBackdropBloc.close();
    movieTabBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieCarouselBloc>(
          create: (context) => movieCarouselBloc,
        ),
        BlocProvider<MovieBackdropBloc>(
          create: (context) => movieBackdropBloc,
        ),
        BlocProvider<MovieTabBloc>(
          create: (context) => movieTabBloc,
        )
      ],
      child: SafeArea(
        child: Scaffold(
          drawer: const NavDrawer(),
          body: BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
            bloc: movieCarouselBloc,
            builder: (context, state) {
              if (state.status == CarouselStatus.success) {
                return Stack(
                  fit: StackFit.expand, //allows to all availabel space
                  children: [
                    FractionallySizedBox(
                        heightFactor: .6,
                        alignment: Alignment.topCenter,
                        child: MovieCarouselWidget(
                            movies: state.movies!,
                            defaultIndex: state.defaultindex!)),
                    const FractionallySizedBox(
                        heightFactor: .4,
                        alignment: Alignment.bottomCenter,
                        child: MovieTab())
                  ],
                );
              } else if (state.status == CarouselStatus.error) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ApperrorWidgets(
                    onPressed: () =>
                        movieCarouselBloc.add(const CarouselLoadEvent()),
                    appErrorType: state.errorType!,
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
