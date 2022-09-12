class SavedPassword {
  int? id;
  String? name;
  String? email;
  String? username;
  String? password;

  SavedPassword(
      {required this.name,
      required this.email,
      required this.username,
      required this.password});

  SavedPassword.withId(
      {required this.id,
      required this.name,
      required this.email,
      required this.username,
      required this.password});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["name"] = name;
    map["email"] = email;
    map["username"] = username;
    map["password"] = password;

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  SavedPassword.fromObject(dynamic o) {
    id = int.tryParse(o["id"].toString())!;
    name = o["name"];
    email = o["email"];
    username = o["username"];
    password = o["password"];
  }
}
