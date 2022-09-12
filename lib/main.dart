import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/blocs/dark_theme_provider.dart';
import 'package:password_generator/blocs/dark_theme_styles.dart';
import 'package:password_generator/blocs/messages.dart';
import 'package:password_generator/blocs/shared_preferences_language.dart';
import 'package:password_generator/screens/password_generator_screen.dart';
import 'package:password_generator/screens/saved_passwords_screen.dart';
import 'package:password_generator/screens/settings_screen.dart';
import 'package:provider/provider.dart';

import 'screens/save_password_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  LanguagePreference languagePreference = LanguagePreference();

  Locale _locale = Locale('en_US');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  void initState() {
    super.initState();

    getCurrentAppTheme();
    getCurrentLanguage();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  void getCurrentLanguage() async {
    Get.updateLocale(await languagePreference.getLanguageAsLocale());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return GetMaterialApp(
            translations: Messages(),
            locale: _locale,
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            title: "password_generator".tr,
            routes: {
              "/": (BuildContext context) => PasswordGeneratorScreen(),
              "/settings": (BuildContext context) => SettingsScreen(),
              "/savedpasswordsscreen": (BuildContext context) =>
                  SavedPasswordsScreen(),
              "/savepasswordsscreen": (BuildContext context) =>
                  SavePasswordsScreen(),
            },
            initialRoute: "/",
          );
        },
      ),
    );
  }
}
