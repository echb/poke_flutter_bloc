import 'package:shared_preferences/shared_preferences.dart';

class Local {
  static final Local _singleton = Local._internal();

  Local._internal();

  factory Local() {
    return _singleton;
  }

  late SharedPreferences local;

  Future<void> init() async {
    local = await SharedPreferences.getInstance();
  }

  List<String>? getFavourites(String key) {
    return local.getStringList(key);
  }

  Future<bool> setFavourite(String key, List<String> value) async {
    return local.setStringList(key, value);
  }
}
