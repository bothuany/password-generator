import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/screens/save_password_screen.dart';
import 'package:password_generator/screens/saved_password_detail_screen.dart';

import '../blocs/saved_password_bloc.dart';
import '../data/saved_password_service.dart';
import '../models/saved_password.dart';

class SavedPasswordsScreen extends StatefulWidget {
  SavedPasswordsScreen();
  @override
  _SavedPasswordsScreenState createState() => _SavedPasswordsScreenState();
}

class _SavedPasswordsScreenState extends State {
  List<SavedPassword>? savedPasswords;
  var savedPasswordBloc = SavedPasswordBloc(SavedPasswordService());
  int savedPasswordsCount = 0;

  void initState() {
    getSavedPasswords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getSavedPasswords();
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'saved_passwords'.tr,
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: buildGoToSavePasswordsButton(),
                ),
              ],
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              backgroundColor: Colors.primaries[0],
            ),
            body: Center(child: buildSavedPasswordsList())));
  }

  buildSavedPasswordsList() {
    if (savedPasswords == null) {
      return CircularProgressIndicator();
    }
    var length = savedPasswords!.length;
    return ListView.separated(
      itemCount: length,
      itemBuilder: (BuildContext context, int position) {
        return ListTile(
          title: Text(
            savedPasswords?[length - position - 1].name ?? "",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
          onTap: () =>
              _onTapItem(context, savedPasswords![length - position - 1]),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              delete(savedPasswords![length - position - 1].id ?? -1);
              setState(() {
                savedPasswords?.remove(savedPasswords![length - position - 1]);
              });
            },
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  buildGoToSavePasswordsButton() {
    return IconButton(
      icon: Icon(Icons.add, size: 36),
      onPressed: () {
        goToSavePassword();
      },
    );
  }

  void getSavedPasswords() async {
    var savedPasswordsFuture = savedPasswordBloc.getSavedPasswords();
    savedPasswordsFuture.then((data) {
      setState(() {
        savedPasswords = data;
        savedPasswordsCount = data.length;
      });
    });
  }

  _onTapItem(BuildContext context, SavedPassword savedPassword) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SavedPasswordDetailsScreen(savedPassword),
      ),
    );
    if (result != null) {
      if (result) {
        getSavedPasswords();
      }
    }
  }

  void goToSavePassword() async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SavePasswordsScreen()));
    if (result != null) {
      if (result) {
        getSavedPasswords();
      }
    }
  }

  void delete(int id) async {
    var result = await savedPasswordBloc.delete(id);
  }
}
