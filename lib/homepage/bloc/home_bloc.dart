import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Map<int, String> selectedanswers = {};
  HomeBloc() : super(HomeState.initial()) {
    // Register the event handler for LoadRandomMCqEvent
    on<LoadRandomMCqEvent>((event, emit) async {
      emit(HomeState.loading());

      try {
        if (event.mcqs.length < 20) {
          emit(HomeState.error('Not enough MCQs available.'));
          return;
        }

        final random = Random();
        final selectedIndexes = <int>{};//to store unique random indexes from 0 to 20

        // Select 20 random unique indexes
        while (selectedIndexes.length < 20) {
          selectedIndexes.add(random.nextInt(event.mcqs.length));
        }

        // Map selected indexes to MCQs
        final randomMcqs =
            selectedIndexes.map((index) => event.mcqs[index]).toList();

        // Emit the loaded state with the selected MCQs
        emit(HomeState.loaded(randomMcqs, event.setnumber));
      } catch (e) {
        emit(HomeState.error("An error occurred: ${e.toString()}"));
      }
    });

    on<ReviewEvent>(
      (event, emit) async {
        final prefs = await SharedPreferences.getInstance();
        for (var i = 0; i < event.randomelements.length; i++) {
          final id = event.randomelements[i]['id'];
          final answer = prefs.getString('set_${event.setnumber}_QN_$id');
          if (answer != null) {
            selectedanswers[i] = answer;
          }
        }
        emit(HomeState.review(selectedanswers));
      },
    );
  }
}
