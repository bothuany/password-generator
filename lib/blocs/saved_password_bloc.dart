import '../data/saved_password_service.dart';
import '../models/saved_password.dart';

class SavedPasswordBloc {
  SavedPasswordService savedPasswordService;

  SavedPasswordBloc(this.savedPasswordService);

  Future<List<SavedPassword>> getSavedPasswords() async {
    return await savedPasswordService.getSavedPasswords();
  }

  Future<int> insert(SavedPassword savedpassword) async {
    var result = await savedPasswordService.insert(savedpassword);
    return result;
  }

  Future<int> delete(int id) async {
    var result = await savedPasswordService.delete(id);
    return result;
  }

  Future<int> update(SavedPassword savedpassword) async {
    var result = await savedPasswordService.update(savedpassword);
    return result;
  }
}
