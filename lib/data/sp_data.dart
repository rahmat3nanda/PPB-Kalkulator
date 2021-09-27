import 'package:kalkukator/common/constans.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPData {
  Future loadFromSP(String key, SharedDataType type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (type) {
      case SharedDataType.bool:
        return prefs.getBool(key);
      case SharedDataType.int:
        return prefs.getInt(key);
      case SharedDataType.string:
        return prefs.getString(key);
      default:
        return null;
    }
  }

  Future saveToSP(String key, SharedDataType type, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      switch (type) {
        case SharedDataType.bool:
          return await prefs.setBool(key, value);
        case SharedDataType.int:
          return await prefs.setInt(key, value);
        case SharedDataType.string:
          return await prefs.setString(key, value);
        default:
          return null;
      }
    } catch (e) {
      return e;
    }
  }

  Future resetSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return await prefs.clear();
    } catch (e) {
      return e;
    }
  }
}
