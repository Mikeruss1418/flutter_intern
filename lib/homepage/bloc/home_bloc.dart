import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Map<int, String> selectedanswers = {};//index as key and answer as value
  HomeBloc() : super(HomeState.initial()) {
    // Register the event handler for LoadRandomMCqEvent
    on<LoadRandomMCqEvent>((event, emit) async {
      emit(HomeState.loading());

      try {
        if (event.mcqs.length < 300) {
          emit(HomeState.error('Not enough MCQs available.'));
          return;
        }

        final random = Random();
        final selectedIndexes =
            <int>{}; //to store unique random indexes from 0 to 20

        // Select 20 random unique indexes
        while (selectedIndexes.length < 300) {
          selectedIndexes.add(random.nextInt(event.mcqs.length));
        }

        // Map selected indexes to MCQs
       /// This line of code is creating a list of randomly selected MCQs (Multiple Choice Questions)
       /// from the provided list of MCQs based on the randomly generated indexes stored in
       /// `selectedIndexes`.
        final randomMcqs =
            selectedIndexes.map((index) => event.mcqs[index]).toList();

        // Emit the loaded state with the selected MCQs
        emit(HomeState.loaded(randomMcqs, event.setnumber));
      } catch (e) {
        emit(HomeState.error("An error occurred: ${e.toString()}"));
      }
    });
  }
}
