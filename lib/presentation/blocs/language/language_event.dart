part of 'language_bloc.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ToggleLangEvent extends LanguageEvent {
  final LangEntity language;

  const ToggleLangEvent({required this.language});
  // final int currentindex;

  
  @override
  List<Object> get props => [language.code];
}
