

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    // Register the event handler for LoadRandomMCqEvent
    on<LoadRandomMCqEvent>((event, emit) async {
      emit(HomeState.loading());

      try {
        if (event.mcqs.length < 5) {
          emit(HomeState.error('Not enough MCQs available.'));
          return;
        }

        final random = Random();
        final selectedIndexes = <int>{};

        // Select 5 random unique indexes
        while (selectedIndexes.length < 5) {
          selectedIndexes.add(random.nextInt(event.mcqs.length));
        }

        // Map selected indexes to MCQs
        final randomMcqs = selectedIndexes.map((index) => event.mcqs[index]).toList();

        // Emit the loaded state with the selected MCQs
        emit(HomeState.loaded(randomMcqs,event.setnumber));
      } catch (e) {
        emit(HomeState.error("An error occurred: ${e.toString()}"));
      }
    });
  }
}
