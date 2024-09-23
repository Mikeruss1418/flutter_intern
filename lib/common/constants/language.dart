import 'package:movie_app/domain/entities/lang_entity.dart';

class Language {
  Language._();
  static List<LangEntity> languages = [
    LangEntity(code: 'en',value: 'English'),
    LangEntity(code: 'es',value: 'Spanish'),
  ];
}
