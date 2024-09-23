part of 'language_bloc.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ToggleLangEvent extends LanguageEvent {
  final LangEntity language;
  // final int currentindex;

  const ToggleLangEvent(
    this.language,
    // this.currentindex
    );
  @override
  List<Object> get props => [language.code];
}
