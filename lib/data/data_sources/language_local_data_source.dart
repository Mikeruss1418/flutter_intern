import 'package:hive/hive.dart';

abstract class LanguageLocalDataSource {
  Future updatelanguage(String language);
  Future<String> getPreferredlang();
}

class LanguageLocalDataSourceIml extends LanguageLocalDataSource {
  @override
  Future<String> getPreferredlang() async {
    final langBox = await Hive.openBox('langBox');
    return langBox.get('language_selected');
  }

  @override
  Future updatelanguage(String language) async {
    final langBox = await Hive.openBox('langBox');
    return langBox.put('language_selected', language);
  }
}
/**
 * import 'package:shared_preferences/shared_preferences.dart';

abstract class LanguageLocalDataSource {
  Future updateLanguage(String language);
  Future<String> getPreferredLang();
}

class LanguageLocalDataSourceImpl extends LanguageLocalDataSource {
  @override
  Future<String> getPreferredLang() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('language_selected');
  }

  @override
  Future updateLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('language_selected', language);
  }
}
 */