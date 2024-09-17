part of 'mcq_bloc.dart';

@immutable
sealed class McqEvent {}

class SaveAllAnswerEvent extends McqEvent {
  final List<Map<String, dynamic>> questions;
  final Map<int, String> answer;
  final int setnumber;
  SaveAllAnswerEvent(
      {required this.questions, required this.answer, required this.setnumber});
}

class ClearSavedAnswersEvent extends McqEvent {
  final List<Map<String, dynamic>> questions;
  final int setnumber;

  ClearSavedAnswersEvent({required this.questions, required this.setnumber});
}

class LoadSavedAnswerEvent extends McqEvent {
  final List<Map<String, dynamic>> questions;
  final int setnumber;

  LoadSavedAnswerEvent({required this.setnumber, required this.questions});
}

class SelectedAnswerEvent extends McqEvent {
  final int questionindex;
  final String selectedanswer;

  SelectedAnswerEvent(
      {required this.questionindex, required this.selectedanswer});
}

class SaveEachAnswerEvent extends McqEvent {
  final int setnuber;
  final int questionid;
  final String selectedanswer;

  SaveEachAnswerEvent(
      {required this.setnuber,
      required this.questionid,
      required this.selectedanswer});
}
