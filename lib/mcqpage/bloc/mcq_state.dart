part of 'mcq_bloc.dart';

class McqState {
  final Map<int, String> selectedanswers;

  McqState({

    required this.selectedanswers});

  McqState copyWith({

    Map<int,String>? selectedanswers,
  }) {
    return McqState(
        selectedanswers: selectedanswers ?? this.selectedanswers,
        );
  }
}
