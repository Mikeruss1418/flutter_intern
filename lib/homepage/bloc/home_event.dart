// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LoadRandomMCqEvent extends HomeEvent {
  final List<Map<String, dynamic>> mcqs;
  final int setnumber;//set track

  LoadRandomMCqEvent({
    required this.mcqs,required this.setnumber
  });
}
