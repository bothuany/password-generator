import '../models/saved_password.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SavedPasswordService {
  Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }

    return _db!;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "savedpasswords.db");
    var savedPasswordsDb =
        await openDatabase(dbPath, version: 1, onCreate: createDb);
    return savedPasswordsDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table savedpasswords(id integer primary key, name text, email text,username text, password text)");
  }

  Future<List<SavedPassword>> getSavedPasswords() async {
    Database db = await this.db;
    var result = await db.query("savedpasswords");
    return List.generate(result.length, (index) {
      return SavedPassword.fromObject(result[index]);
    });
  }

  Future<int> insert(SavedPassword savedpassword) async {
    Database db = await this.db;
    var result = await db.insert("savedpasswords", savedpassword.toMap());
    return result;

  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from savedpasswords where id=$id");
    return result;
  }

  Future<int> update(SavedPassword savedpassword) async {
    Database db = await this.db;
    var result = await db.update("savedpasswords", savedpassword.toMap(),
        where: "id=?", whereArgs: [savedpassword.id]);
    return result;
  }
}
