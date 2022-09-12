import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreference {
  static const LANGUAGE = "LANGUAGE";

  setLanguage(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LANGUAGE, value);
  }

  Future<String> getLanguageAsCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(LANGUAGE) ?? "en_US";
  }

  Future<Locale> getLanguageAsLocale() async {
    String languageCode = await getLanguageAsCode();

    if (languageCode == "tr_TR") {
      return Locale("tr_TR");
    } else
      return Locale("en_US");
  }
}
