import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/lang_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/use_cases/preferred_lang.dart';
import 'package:movie_app/domain/use_cases/update_language.dart';

import '../../../common/constants/language.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final PreferredLang preferredLang;
  final UpdateLanguage updateLanguage;
  LanguageBloc({
    required this.preferredLang,
    required this.updateLanguage,
  }) : super(LanguageState(
            status: LanguageStatus.toggled,
            locale: Locale(Language.languages[0].code))) {
    on<ToggleLangEvent>(toggleLangEvent);
    on<LoadPreferredLanguageEvent>(loadPreferredLanguageEvent);
  }

  Future<void> toggleLangEvent(
      ToggleLangEvent event, Emitter<LanguageState> emit) async {
    await updateLanguage(event.language.code);
    add(LoadPreferredLanguageEvent()); // emit(state.copyWith(
    //     status: LanguageStatus.toggled, locale: Locale(event.language.code)));
  }

  Future<void> loadPreferredLanguageEvent(
      LoadPreferredLanguageEvent event, Emitter<LanguageState> emit) async {
    final reponse = await preferredLang(NoParams());
    reponse.fold(
      (l) => emit(state.copyWith(status: LanguageStatus.error)),
      (r) {
        emit(state.copyWith(status: LanguageStatus.toggled, locale: Locale(r)));
      },
    );
  }
}
