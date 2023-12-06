import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefernceHelper {
  static String userIdKey = "USERIDKEY";
  static String userNameKey = "USERNAMEKEY";
  static String useremailKey = "USEREMAILKEY";
  static String userPicKey = "USERPICKEY";
  static String displayNameKey = "DISPLAYNAME";


  //// SAVE USER DETAILS IN SHARED PREFERENCE
  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }

  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserDisplayName(String getUserDisplayName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(displayNameKey, getUserDisplayName);
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(useremailKey, getUserEmail);
  }

  Future<bool> saveUserPic(String getUserPic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userPicKey, getUserPic);
  }


  ///// GET USER DETAILS FROM SHARED PREFERENCE
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String?> getUserDisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(displayNameKey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(useremailKey);
  }

  Future<String?> getUserPic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userPicKey);
  }

}
