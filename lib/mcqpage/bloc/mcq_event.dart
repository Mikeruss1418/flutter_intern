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
