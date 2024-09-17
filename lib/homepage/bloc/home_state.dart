part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded, error, saveallanswer }

class HomeState {
  final HomeStatus status;
  final List<Map<String, dynamic>>? randomMcqs;
  final int? setnumber;
  final String? errorMessage;
  

  const HomeState._({
    required this.status,
    this.randomMcqs,
    this.setnumber,
    this.errorMessage,
  });

  // Initial state
  factory HomeState.initial() => const HomeState._(status: HomeStatus.initial);

  // Loading state
  factory HomeState.loading() => const HomeState._(status: HomeStatus.loading);

  // Loaded state with random MCQs
  factory HomeState.loaded(
          List<Map<String, dynamic>> randomMcqs, int setnumber) =>
      HomeState._(
          status: HomeStatus.loaded,
          randomMcqs: randomMcqs,
          setnumber: setnumber);

  // Error state
  factory HomeState.error(String message) =>
      HomeState._(status: HomeStatus.error, errorMessage: message);
  // // Review class states

  factory HomeState.saveallanswer() =>
      const HomeState._(status: HomeStatus.saveallanswer);
}
