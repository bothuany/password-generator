import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/blocs/saved_password_bloc.dart';

import 'package:password_generator/models/saved_password.dart';

import '../data/saved_password_service.dart';

class SavePasswordsScreen extends StatefulWidget {
  String? password;
  SavePasswordsScreen({this.password});
  @override
  _SavePasswordsScreenState createState() =>
      _SavePasswordsScreenState(password: password);
}

class _SavePasswordsScreenState extends State {
  String? password;
  _SavePasswordsScreenState({this.password});

  var savedPasswordBloc = SavedPasswordBloc(SavedPasswordService());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'save_password'.tr,
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: Colors.amberAccent,
          ),
          body: Center(
            child: Column(
              children: [
                buildNameField(),
                buildEmailField(),
                buildUsernameField(),
                buildPasswordField(),
                buildSaveButton()
              ],
            ),
          ),
        ));
  }

  buildNameField() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        controller: nameController,
        maxLength: 28,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'name'.tr,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  buildEmailField() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        controller: emailController,
        maxLength: 28,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'email'.tr,
          helperText: 'optional'.tr,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  buildUsernameField() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        controller: usernameController,
        maxLength: 28,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'username'.tr,
          helperText: 'optional'.tr,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  buildPasswordField() {
    passwordController.text = password ?? "";
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        controller: passwordController,
        maxLength: 28,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'password'.tr,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  buildSaveButton() {
    return ElevatedButton.icon(
      onPressed: () {
        if (nameController.text.length > 0 &&
            passwordController.text.length > 0) {
          save();
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('please_fill_in_name_and_password_fields'.tr),
            ),
          );
        }
      },
      icon: Icon(Icons.save, size: 24),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black45),
      ),
      label: Text("save".tr, style: TextStyle(fontSize: 24)),
    );
  }

  void save() async {
    var result = await savedPasswordBloc.insert(SavedPassword(
      name: nameController.text,
      email: emailController.text,
      username: usernameController.text,
      password: passwordController.text,
    ));
  }
}
