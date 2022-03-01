import 'package:shared_preferences/shared_preferences.dart';

import 'constants/strings.dart';

class SPHelper {
  addUid(uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(StringConstant.UID, uid);
  }

  getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(StringConstant.UID);
    return uid;
  }

  setIsLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(StringConstant.isLoggedIn, isLoggedIn);
  }

  getIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool(StringConstant.isLoggedIn);
    return isLoggedIn;
  }
}
