import 'package:chat_mingle/services/shared_pref.dart';
import 'package:flutter/material.dart';

class SharedPrefNotifier extends ChangeNotifier {
  Map<String, dynamic> currentUser = {};
  Future<void> getSharedPref() async {
    currentUser['name'] = await SharedPrefernceHelper().getUserDisplayName();
    currentUser['uid'] = await SharedPrefernceHelper().getUserId();
    currentUser['user_name'] = await SharedPrefernceHelper().getUserName();
    currentUser['email'] = await SharedPrefernceHelper().getUserEmail();
    currentUser['prof_pic'] = await SharedPrefernceHelper().getUserPic();
    notifyListeners();
  }
}
