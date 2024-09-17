import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmccqq/homepage/bloc/home_bloc.dart';
import 'package:mmccqq/mcqpage/bloc/mcq_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (bloc is McqBloc) {
      log('McqBloc Event: $event');
    }
    if (bloc is HomeBloc) {
      log('HomeBloc Event: $event');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (bloc is McqBloc) {
      log('McqBloc Transition: ${transition.event.runtimeType} -> ${transition.nextState}');
    }
    if (bloc is HomeBloc) {
      log('HomeBloc Transition:${transition.event.runtimeType} -> ${transition.nextState.runtimeType}');
    }
  }
}
