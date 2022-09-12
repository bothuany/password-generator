import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:password_generator/blocs/saved_password_bloc.dart';
import 'package:password_generator/data/saved_password_service.dart';
import 'package:password_generator/models/saved_password.dart';

class SavedPasswordDetailsScreen extends StatefulWidget {
  SavedPassword? savedPassword;
  SavedPasswordDetailsScreen(this.savedPassword);
  @override
  _SavedPasswordDetailsScreenState createState() =>
      _SavedPasswordDetailsScreenState(this.savedPassword);
}

class _SavedPasswordDetailsScreenState extends State {
  SavedPassword? savedPassword;
  _SavedPasswordDetailsScreenState(this.savedPassword);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'details'.tr,
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: buildUpdateSavedPasswordButton(),
              ),
            ],
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: Colors.blueAccent,
          ),
          body: buildBody(),
        ));
  }

  bool editName = false;
  final nameController = TextEditingController();
  bool editEmail = false;
  final emailController = TextEditingController();
  bool editUsername = false;
  final usernameController = TextEditingController();
  bool editPassword = false;
  final passwordController = TextEditingController();

  buildNameDetail() {
    if (savedPassword!.name == "") {
      return Container();
    }
    if (editName) {
      nameController.text = (nameController.text.length > 0)
          ? nameController.text
          : savedPassword?.name ?? "";
      return Padding(
        padding: EdgeInsets.all(12),
        child: TextField(
          controller: nameController,
          textInputAction: TextInputAction.done,
          maxLength: 28,
          decoration: InputDecoration(
            labelText: 'name'.tr,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.close,
              ),
              onPressed: () => {
                setState(() => {editName = false})
              },
            ),
          ),
        ),
      );
    }
    return Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Text(
              "name: ".tr,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Text(
                savedPassword?.name ?? "",
                style: TextStyle(fontSize: 19),
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.edit,
              ),
              onPressed: () => {
                setState(() => {
                      nameController.text = savedPassword?.name ?? "",
                      editName = true
                    })
              },
            ),
            IconButton(
              icon: Icon(
                Icons.copy,
              ),
              onPressed: () => {
                Clipboard.setData(ClipboardData(
                  text: savedPassword!.name,
                )),
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("copied_to_clipboard".tr),
                  ),
                ),
              },
            ),
          ],
        ));
  }

  buildEmailDetail() {
    if (savedPassword!.email == "") {
      return Container();
    }
    if (editEmail) {
      emailController.text = (emailController.text.length > 0)
          ? emailController.text
          : savedPassword?.email ?? "";

      return Padding(
        padding: EdgeInsets.all(12),
        child: TextField(
          controller: emailController,
          textInputAction: TextInputAction.done,
          maxLength: 28,
          decoration: InputDecoration(
            labelText: 'email'.tr,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.close,
              ),
              onPressed: () => {
                setState(() => {editEmail = false})
              },
            ),
          ),
        ),
      );
    }
    return Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Text(
              "email: ".tr,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Text(
                savedPassword?.email ?? "",
                style: TextStyle(fontSize: 19),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
              ),
              onPressed: () => {
                setState(() => {
                      emailController.text = savedPassword?.email ?? "",
                      editEmail = true
                    })
              },
            ),
            IconButton(
              icon: Icon(
                Icons.copy,
              ),
              onPressed: () => {
                Clipboard.setData(ClipboardData(
                  text: savedPassword!.email,
                )),
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("copied_to_clipboard".tr),
                  ),
                ),
              },
            ),
          ],
        ));
  }

  buildUsernameDetail() {
    if (savedPassword!.username == "") {
      return Container();
    }
    if (editUsername) {
      usernameController.text = (usernameController.text.length > 0)
          ? usernameController.text
          : savedPassword?.username ?? "";

      return Padding(
        padding: EdgeInsets.all(12),
        child: TextField(
          controller: usernameController,
          textInputAction: TextInputAction.done,
          maxLength: 28,
          decoration: InputDecoration(
            labelText: 'username'.tr,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.close,
              ),
              onPressed: () => {
                setState(() => {editUsername = false})
              },
            ),
          ),
        ),
      );
    }
    return Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Text(
              "username: ".tr,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Text(
                savedPassword?.username ?? "",
                style: TextStyle(fontSize: 19),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
              ),
              onPressed: () => {
                setState(() => {
                      usernameController.text = savedPassword?.username ?? "",
                      editUsername = true
                    })
              },
            ),
            IconButton(
              icon: Icon(
                Icons.copy,
              ),
              onPressed: () => {
                Clipboard.setData(ClipboardData(
                  text: savedPassword!.username,
                )),
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('copied_to_clipboard'.tr),
                  ),
                ),
              },
            ),
          ],
        ));
  }

  buildPasswordDetail() {
    if (savedPassword!.password == "") {
      return Container();
    }
    if (editPassword) {
      passwordController.text = (passwordController.text.length > 0)
          ? passwordController.text
          : savedPassword?.password ?? "";

      return Padding(
        padding: EdgeInsets.all(12),
        child: TextField(
          controller: passwordController,
          textInputAction: TextInputAction.send,
          maxLength: 28,
          decoration: InputDecoration(
            labelText: 'password'.tr,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.close,
              ),
              onPressed: () => {
                setState(() => {editPassword = false})
              },
            ),
          ),
        ),
      );
    }
    return Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Text(
              "password: ".tr,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Text(
                savedPassword?.password ?? "",
                style: TextStyle(fontSize: 19),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
              ),
              onPressed: () => {
                setState(() => {
                      passwordController.text = savedPassword?.password ?? "",
                      editPassword = true
                    })
              },
            ),
            IconButton(
              icon: Icon(
                Icons.copy,
              ),
              onPressed: () => {
                Clipboard.setData(ClipboardData(
                  text: savedPassword!.password,
                )),
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('copied_to_clipboard'.tr),
                  ),
                ),
              },
            ),
          ],
        ));
  }

  buildBody() {
    return ListView(
      children: ListTile.divideTiles(
          //          <-- ListTile.divideTiles
          context: context,
          tiles: [
            buildNameDetail(),
            buildEmailDetail(),
            buildUsernameDetail(),
            buildPasswordDetail(),
          ]).toList(),
    );
  }

  bool getIsNameUpdated(name) {
    bool result = false;
    if (name == null)
      result = false;
    else if (nameController.text == "")
      result = false;
    else if (name == nameController.text)
      result = false;
    else
      result = true;

    return result;
  }

  bool getIsEmailUpdated(email) {
    bool result = false;
    if (email == null)
      result = false;
    else if (emailController.text == "")
      result = false;
    else if (email == emailController.text)
      result = false;
    else
      result = true;

    return result;
  }

  bool getIsUsernameUpdated(username) {
    bool result = false;
    if (username == null)
      result = false;
    else if (usernameController.text == "")
      result = false;
    else if (username == usernameController.text)
      result = false;
    else
      result = true;

    return result;
  }

  bool getIsPasswordUpdated(password) {
    bool result = false;
    if (password == null)
      result = false;
    else if (passwordController.text == "")
      result = false;
    else if (password == passwordController.text)
      result = false;
    else
      result = true;

    return result;
  }

  bool getIsUpdated(name, email, username, password) {
    return (getIsNameUpdated(name) ||
        getIsEmailUpdated(email) ||
        getIsUsernameUpdated(username) ||
        getIsPasswordUpdated(password));
  }

  var savedPasswordBloc = SavedPasswordBloc(SavedPasswordService());
  update() async {
    await savedPasswordBloc.update(savedPassword!);
  }

  buildUpdateSavedPasswordButton() {
    String? name = savedPassword?.name;
    String? email = savedPassword?.email;
    String? username = savedPassword?.username;
    String? password = savedPassword?.password;

    return IconButton(
      icon: Icon(Icons.save, size: 36),
      onPressed: () => {
        if (getIsUpdated(name, email, username, password) == false)
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('no_change_to_save'.tr),
              ),
            ),
          }
        else
          {
            setState(() {
              editName = false;
              editEmail = false;
              editUsername = false;
              editPassword = false;

              savedPassword = new SavedPassword.withId(
                  id: savedPassword!.id,
                  name: (getIsNameUpdated(name) ? nameController.text : name),
                  email:
                      (getIsEmailUpdated(email) ? emailController.text : email),
                  username: (getIsUsernameUpdated(username)
                      ? usernameController.text
                      : username),
                  password: (getIsPasswordUpdated(password)
                      ? passwordController.text
                      : password));
            }),
            update(),
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('saved_successfully'.tr),
              ),
            ),
          }
      },
    );
  }
}
