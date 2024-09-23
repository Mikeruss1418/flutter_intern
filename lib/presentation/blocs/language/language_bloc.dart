import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/lang_entity.dart';

import '../../../common/constants/language.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState(status: LanguageStatus.toggled,locale: Locale(Language.languages[0].code))) {
    on<ToggleLangEvent>(toggleLangEvent);
  }

  FutureOr<void> toggleLangEvent(
      ToggleLangEvent event, Emitter<LanguageState> emit) {
    emit(
        state.copyWith(status: LanguageStatus.toggled, locale: Locale(event.language.code)));
  }
}
