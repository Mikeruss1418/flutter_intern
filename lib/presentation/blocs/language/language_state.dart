part of 'language_bloc.dart';

enum LanguageStatus {
  initial,
  toggled,
}

class LanguageState extends Equatable {
  const LanguageState({required this.status, this.locale});
  final LanguageStatus status;
  final Locale? locale;

  static LanguageState initial() => const LanguageState(status: LanguageStatus.initial,);

  LanguageState copyWith({
    LanguageStatus? status, Locale? locale
  }) => LanguageState(status: status ?? this.status, locale: locale ??  this.locale);
  @override
  List<Object> get props => [status, locale?.languageCode ?? ''];
}
