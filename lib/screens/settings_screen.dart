import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/blocs/dark_theme_provider.dart';
import 'package:password_generator/blocs/shared_preferences_language.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State {
  Map<String, String> languages = {"English": "en_US", "Turkish": "tr_TR"};
  String activeLanguage = Get.locale!.languageCode.tr;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final languagePreference = LanguagePreference();

    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(children: [
        buildDarkModeSwitch(themeChange),
        buildLanguageMenu(languagePreference)
      ]),
    );
  }

  buildLanguageMenu(languagePreference) {
    var languagesList = <PopupMenuEntry>[];

    languages.keys.forEach((key) {
      languagesList.add(PopupMenuItem(
        child: Text(key),
        value: languages[key],
      ));
    });

    return Expanded(
        child: PopupMenuButton(
      child: ListTile(
        leading: Icon(Icons.language),
        title: Text("language".tr),
        subtitle: Text(activeLanguage),
      ),
      position: PopupMenuPosition.over,
      onSelected: (value) {
        setState(() {
          activeLanguage = languages.keys.firstWhere(
              (element) => languages[element] == value,
              orElse: () => "english".tr);
          languagePreference.setLanguage(value);
        });
        Get.updateLocale(Locale(value));
      },
      itemBuilder: (BuildContext context) => languagesList,
    ));
  }

  buildDarkModeSwitch(themeChange) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.dark_mode),
          SizedBox(
            width: 32,
          ),
          Text('dark_mode'.tr, style: TextStyle(fontSize: 16)),
          Spacer(),
          Switch(
            value: themeChange.darkTheme,
            activeColor: Colors.deepPurpleAccent,
            onChanged: (value) {
              themeChange.darkTheme = value;
            },
          )
        ],
      ),
    );
  }
}
