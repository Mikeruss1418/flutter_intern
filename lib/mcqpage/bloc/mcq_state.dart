part of 'mcq_bloc.dart';

class McqState {
  // final List<int> attemptedqns;
  // final int? selectedqns;
  final Map<int, String> selectedanswers;

  McqState({
    // required this.attemptedqns, this.selectedqns,
    required this.selectedanswers});

  McqState copyWith({
    // List<int>? attemptedqns,
    // int? selectedqns,
    Map<int,String>? selectedanswers,
  }) {
    return McqState(
        // attemptedqns: attemptedqns ?? this.attemptedqns,
        // selectedqns: selectedqns ?? this.selectedqns,
        selectedanswers: selectedanswers ?? this.selectedanswers,
        );
  }
}
