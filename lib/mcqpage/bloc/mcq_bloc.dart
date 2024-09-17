import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'mcq_event.dart';
part 'mcq_state.dart';

class McqBloc extends Bloc<McqEvent, McqState> {
  Timer? timer;
  McqBloc() : super(McqState(
            // attemptedqns: [],
            selectedanswers: {})) {
    on<SaveAllAnswerEvent>(
      (event, emit) async {
        final prefs = await SharedPreferences.getInstance();
        HtmlUnescape unescape = HtmlUnescape();

        // Save selected answers
        Map<String, dynamic> decodedAnswers = event.answer.map((key, value) {
          return MapEntry(key.toString(), unescape.convert(value));
        });
        String answersJson = jsonEncode(decodedAnswers);
        // await prefs.setString(
        //     'set_${event.questions[0]['setnumber']}_answers', answersJson);
        await prefs.setString('set_${event.setnumber}_answers', answersJson);

        // Save the entire set of questions
        String questionsJson = jsonEncode(event.questions);
        // await prefs.setString(
        //     'set_${event.questions[0]['setnumber']}_questions', questionsJson);
        await prefs.setString(
            'set_${event.setnumber}_questions', questionsJson);
      },
    );

    on<ClearSavedAnswersEvent>(
      (event, emit) async {
        for (var element in event.questions) {
          final prefs = await SharedPreferences.getInstance();
          final id = element['id'];
          await prefs.remove('set_${event.setnumber}_QN_$id');
        }
        log('All answers for set ${event.setnumber} have been cleared');
      },
    );

    on<LoadSavedAnswerEvent>(
  (event, emit) async {
    final prefs = await SharedPreferences.getInstance();
    final updatedAnswers = Map<int, String>.from(state.selectedanswers);
    event.questions.asMap().forEach((index, question) {
      final id = question['id'];
      final answer = prefs.getString('set_${event.setnumber}_QN_$id');
      if (answer != null) {
        updatedAnswers[index] = answer;
      }
    });
    emit(state.copyWith(selectedanswers: updatedAnswers));
  },
);

    on<SelectedAnswerEvent>(
      (event, emit) {
        final updatedanswers = Map<int, String>.from(state.selectedanswers);
        updatedanswers[event.questionindex] = event.selectedanswer;
        emit(state.copyWith(selectedanswers: updatedanswers));
      },
    );

    on<SaveEachAnswerEvent>(
      (event, emit) async {
        final pref = await SharedPreferences.getInstance();
        await pref.setString('set_${event.setnuber}_QN_${event.questionid}',
            event.selectedanswer);
      },
    );
  }
}
