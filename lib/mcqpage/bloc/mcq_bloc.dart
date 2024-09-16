import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'mcq_event.dart';
part 'mcq_state.dart';

class McqBloc extends Bloc<McqEvent, McqState> {
  McqBloc() : super(McqState()) {
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
      await prefs.setString(
          'set_${event.setnumber}_answers', answersJson);
          
      // Save the entire set of questions
      String questionsJson = jsonEncode(event.questions);
      // await prefs.setString(
      //     'set_${event.questions[0]['setnumber']}_questions', questionsJson);
      await prefs.setString(
          'set_${event.setnumber}_questions', questionsJson);
      },
    );
  }
}
