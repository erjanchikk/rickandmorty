import 'package:rickandmorty/helpers/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveProvider {
  Future<void> saveUser(String user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefKeys.user, user);
  }

  Future<String?> getUSer() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString(PrefKeys.user);
    return user;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
