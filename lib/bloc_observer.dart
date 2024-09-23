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
import 'package:movie_app/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_tab/movie_tab_bloc.dart';

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
          log(
              'MovieTabBloc: Success state - Current index: ${currentState.currentindex}');
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
  }
}
