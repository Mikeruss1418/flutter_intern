import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mmccqq/homepage/bloc/home_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('Event : ${bloc.runtimeType}, $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('Error : ${bloc.runtimeType}, $error');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is HomeBloc) {
      final currentState = change.currentState;
      final nextState = change.nextState;

      if (currentState is HomeState && nextState is HomeState) {
        log('Onchange : ${bloc.runtimeType}, ${currentState.status} -> ${nextState.status}');
        if (nextState.status == HomeStatus.loaded) {
          // log('Loaded MCQs: ${nextState.randomMcqs}');
          // log('Set Number: ${nextState.setnumber}');
        } else if (nextState.status == HomeStatus.error) {
          log('Error Message: ${nextState.errorMessage}');
        } else if (nextState.status == HomeStatus.review) {
          // log('Selected Answers: ${nextState.selectedanswer}');
        }
      }
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('Transition : ${bloc.runtimeType}, $transition');
  }
}
