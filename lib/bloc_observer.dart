// import 'dart:developer';

// import 'package:flutter_bloc/flutter_bloc.dart';

// class MyBlocObserver extends BlocObserver {
//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     super.onTransition(bloc, transition);
//     log('Bloc Transition: ${transition.event} -> ${transition.nextState}');
//   }

//   @override
//   void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
//     super.onError(bloc, error, stackTrace);
//     log('Bloc Error: $error');
//   }

//   // @override
//   // void onChange(BlocBase bloc, Change change) {
//   //   super.onChange(bloc, change);
//   //   if (bloc is Bloc) {
//   //     final currentState = change.nextState;
//   //     if (currentState.status == AuthStatus.error) {
//   //       log('Bloc Error: ${currentState.errorMessage}');
//   //     }
//   //   }
//   // }
// }
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/blocs/cast/cast_bloc.dart';
import 'package:movie_app/presentation/blocs/language/language_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_tab/movie_tab_bloc.dart';
import 'package:movie_app/presentation/blocs/video/video_bloc.dart';

import 'presentation/blocs/favorite/favorite_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (bloc is MovieTabBloc) {
      final currentState = bloc.state;
      switch (currentState.status) {
        case MovieTabStatus.inital:
          log('MovieTabBloc: Initial state');
          break;
        case MovieTabStatus.success:
          log('MovieTabBloc: Success state - Current index: ${currentState.currentindex}');
          break;
        case MovieTabStatus.fail:
          log('MovieTabBloc: Fail state');
          break;
      }
    }
    if (bloc is MovieCarouselBloc) {
      final currentstate = bloc.state;
      switch (currentstate.status) {
        case CarouselStatus.initial:
          log('MovieCarouselBloc : Initial State');
          break;
        case CarouselStatus.success:
          log('MovieCarouselBloc: Success State - Current Index: ${currentstate.defaultindex}');
          break;
        case CarouselStatus.error:
          log('MovieCarouselBloc: Fail State');
          break;
        default:
      }
    }
    if (bloc is MovieBackdropBloc) {
      final currentstate = bloc.state;
      switch (currentstate.status) {
        case MovieBackdropStatus.inital:
          log('MovieBackDropBloc: Initial State');
          break;
        case MovieBackdropStatus.success:
          log('MovieBackDropBloc: Success State');
          break;
        case MovieBackdropStatus.fail:
          log('MovieBackDropBloc: Fail State');
          break;
        default:
      }
    }
    if (bloc is MovieDetailBloc) {
      final currentstate = bloc.state;
      switch (currentstate.status) {
        case MovieDetailStatus.success:
          log('MovieBackDropBloc: Success State');
          break;
        case MovieDetailStatus.fail:
          log('MovieBackDropBloc: Fail State');
          break;
        default:
      }
    }
    if (bloc is CastBloc) {
      final currentstate = bloc.state;
      switch (currentstate.status) {
        case CastStatus.initial:
          log('CastBloc : Initial State');
          break;
        case CastStatus.success:
          log('CastBloc: Success State');
          break;
        case CastStatus.fail:
          log('CastBloc: Fail State');
          break;
        default:
      }
    }
    if (bloc is LanguageBloc) {
      final currentstate = bloc.state;
      switch (currentstate.status) {
        case LanguageStatus.initial:
          log('LanguageBloc: Initial State');
          break;
        case LanguageStatus.toggled:
          log('LanguageBloc: Success State');
          break;
        default:
      }
    }
    if (bloc is VideoBloc) {
      final currentstate = bloc.state;
      switch (currentstate.status) {
        case VideoStatus.initial:
          log('VideoBloc: Initial State');
          break;
        case VideoStatus.success:
          log('VideoBloc: Success State');
          break;
        case VideoStatus.fail:
          log('VideoBloc: Fail State');
          break;
        default:
      }
    }
    if (bloc is FavoriteBloc) {
      final currentstate = bloc.state;
      switch (currentstate.status) {
        case FavoriteStatus.initial:
          log('FavoriteBloc: Initial State');
          break;
        case FavoriteStatus.loaded:
          log('FavoriteBloc: Success State');
          break;
        case FavoriteStatus.fail:
          log('FavoriteBloc: Fail State');
          break;
        case FavoriteStatus.isFavorite:
          log('FavoriteBloc: isFavorite State');
          break;
        default:
      }
    }
  }
}
