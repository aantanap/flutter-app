// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String prefName = "com.example.home_service_provider";

  static String isLoggedIn = "${prefName}isLoggedIn";
  static String Token = "${prefName}token";
  static String ID = "${prefName}id";
  static String Fullname = "${prefName}fullName";
  static String Username = "${prefName}username";

  static Future<SharedPreferences> getPrefInstance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  static setLogIn(bool avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setBool(isLoggedIn, avail);
  }

  static setToken(String avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(Token, avail);
  }

  static setID(String avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(ID, avail);
  }

  static setFullname(String avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(Fullname, avail);
  }

  static setUsername(String avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(Username, avail);
  }

  static Future<bool> isLogIn() async {
    SharedPreferences preferences = await getPrefInstance();
    bool isIntroAvailable = preferences.getBool(isLoggedIn) ?? false;
    return isIntroAvailable;
  }

  static Future<String> getToken() async {
    SharedPreferences preferences = await getPrefInstance();
    String isIntroAvailable = preferences.getString(Token) ?? "-";
    return isIntroAvailable;
  }

  static Future<String> getID() async {
    SharedPreferences preferences = await getPrefInstance();
    String isIntroAvailable = preferences.getString(ID) ?? "-";
    return isIntroAvailable;
  }

  static Future<String> getFullname() async {
    SharedPreferences preferences = await getPrefInstance();
    String isIntroAvailable = preferences.getString(Fullname) ?? "-";
    return isIntroAvailable;
  }

  static Future<String> getUsername() async {
    SharedPreferences preferences = await getPrefInstance();
    String isIntroAvailable = preferences.getString(Username) ?? "-";
    return isIntroAvailable;
  }
}
