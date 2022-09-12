import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:password_generator/blocs/password_generator_bloc.dart';

import 'save_password_screen.dart';

class PasswordGeneratorScreen extends StatefulWidget {
  @override
  _PasswordGeneratorScreenState createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State {
  int _sliderDiscreteValue = 8;
  bool _includeUppercase = true;
  bool _includeLowercase = true;
  bool _includeNumbers = true;
  bool _includeSpecialCharacters = true;

  final passwordController = TextEditingController();
  double? width;
  double? height;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("title".tr),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: buildGoToSavedPasswordsButton(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: buildGoToSettingsButton(),
            ),
          ],
          backgroundColor: Colors.indigoAccent,
        ),
        body: Center(
          child: Column(children: [
            buildCheckBoxGroup(),
            buildPasswordLength(),
            buildGeneratedPassword(),
            Spacer(),
            buildButtons()
          ]),
        ),
      ),
    );
  }

  buildGoToSavedPasswordsButton() {
    return IconButton(
      icon: Icon(Icons.list, size: 30),
      onPressed: () {
        Navigator.pushNamed(context, "/savedpasswordsscreen");
      },
    );
  }

  buildGoToSettingsButton() {
    return IconButton(
      icon: Icon(Icons.settings, size: 30),
      onPressed: () {
        Navigator.pushNamed(context, "/settings");
      },
    );
  }

  buildPasswordLengthSlider() {
    return Slider(
      value: _sliderDiscreteValue.toDouble(),
      min: 4,
      max: 20,
      divisions: 16,
      label: _sliderDiscreteValue.round().toString(),
      activeColor: Colors.indigoAccent,
      onChanged: (value) {
        setState(() {
          _sliderDiscreteValue = value.toDouble().round();
        });
      },
    );
  }

  buildPasswordLength() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Text(
              "password_length".tr,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              _sliderDiscreteValue.round().toString(),
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            buildPasswordLengthSlider(),
          ],
        ));
  }

  buildCheckBoxGroup() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          buildCheckBoxUppercase(),
          buildCheckBoxLowercase(),
          buildCheckBoxNumbers(),
          buildCheckBoxSpecialCharacters(),
        ],
      ),
    );
  }

  buildCheckBoxUppercase() {
    return CheckboxListTile(
      title: Text("include_uppercase_letters".tr),
      value: _includeUppercase,
      activeColor: Colors.indigoAccent,
      onChanged: (value) {
        setState(() {
          _includeUppercase = (value != false);
        });
      },
    );
  }

  buildCheckBoxLowercase() {
    return CheckboxListTile(
      title: Text("include_lowercase_letters".tr),
      value: _includeLowercase,
      activeColor: Colors.indigoAccent,
      onChanged: (value) {
        setState(() {
          _includeLowercase = (value != false);
        });
      },
    );
  }

  buildCheckBoxNumbers() {
    return CheckboxListTile(
      title: Text("include_numbers".tr),
      value: _includeNumbers,
      activeColor: Colors.indigoAccent,
      onChanged: (value) {
        setState(() {
          _includeNumbers = (value != false);
        });
      },
    );
  }

  buildCheckBoxSpecialCharacters() {
    return CheckboxListTile(
      title: Text("include_special_characters".tr),
      value: _includeSpecialCharacters,
      activeColor: Colors.indigoAccent,
      onChanged: (value) {
        setState(() {
          _includeSpecialCharacters = (value != false);
        });
      },
    );
  }

  buildGeneratedPassword() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        controller: passwordController,
        textInputAction: TextInputAction.done,
        maxLength: 32,
        decoration: InputDecoration(
          labelText: "generated_password".tr,
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.copy,
            ),
            onPressed: () => {
              Clipboard.setData(ClipboardData(text: passwordController.text)),
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("copied_to_clipboard".tr),
                ),
              ),
            },
          ),
        ),
      ),
    );
  }

  buildButtons() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  passwordController.text =
                      PasswordGeneratorBloc.generatePassword(
                    _sliderDiscreteValue,
                    _includeUppercase,
                    _includeLowercase,
                    _includeNumbers,
                    _includeSpecialCharacters,
                  );
                });
              },
              icon: Icon(Icons.add, size: 24),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(width! * 0.45, 35)),
                backgroundColor: MaterialStateProperty.all(Colors.indigoAccent),
              ),
              label: Text("generate".tr, style: TextStyle(fontSize: 24)),
            ),
            Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                navigateToSavePasswordsWithPassword();
              },
              icon: Icon(Icons.arrow_forward_ios, size: 24),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black45),
                fixedSize: MaterialStateProperty.all(Size(width! * 0.45, 35)),
              ),
              label: Text("go_to_save".tr, style: TextStyle(fontSize: 24)),
            )
          ],
        ));
  }

  navigateToSavePasswordsWithPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SavePasswordsScreen(password: passwordController.text),
      ),
    );
  }
}
