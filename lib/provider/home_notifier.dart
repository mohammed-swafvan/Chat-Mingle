import 'package:chat_mingle/models/user_model.dart';
import 'package:chat_mingle/services/firestore_services.dart';
import 'package:chat_mingle/services/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  bool isSearching = false;
  List<UserModel> allUsers = [];
  List<UserModel> foundedUsers = [];
  Map<String, dynamic> currentUser = {};

  void getSharedPref() async {
    currentUser['name'] = await SharedPrefernceHelper().getUserDisplayName();
    currentUser['uid'] = await SharedPrefernceHelper().getUserId();
    currentUser['user_name'] = await SharedPrefernceHelper().getUserName();
    currentUser['email'] = await SharedPrefernceHelper().getUserEmail();
    currentUser['prof_pic'] = await SharedPrefernceHelper().getUserPic();
    notifyListeners();
  }

  void changeSearchVisibility() {
    isSearching = !isSearching;
    if (!isSearching) {
      foundedUsers.clear();
    }
    notifyListeners();
  }

  Future<void> getAllUsers() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirestoreServices().getAllUsers();
    allUsers.clear();
    for (QueryDocumentSnapshot<Map<String, dynamic>> document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data();
      allUsers.add(
        UserModel(
          uid: data['uid'],
          name: data['name'],
          email: data['email'],
          userName: data['user_name'],
          photoUrl: data['photo_url'],
        ),
      );
    }
    notifyListeners();
  }

  runFilter(String value) {
    List<UserModel> result = [];
    if (value.isEmpty) {
      result = [];
    } else {
      result = allUsers.where((element) => element.userName.toLowerCase().startsWith(value.toLowerCase())).toList();
    }
    foundedUsers = result;
    notifyListeners();
  }

  // initiateSearch(String value) {
  //   if (queryResultSet.isEmpty) {
  //     queryResultSet = [];
  //     tempSearchStore = [];
  //     notifyListeners();
  //     FirestoreServices().searchUser(userName: value).then(
  //       (QuerySnapshot querySnapshot) {
  //         for (var i = 0; i < querySnapshot.docs.length; i++) {
  //           queryResultSet.add(querySnapshot.docs[i].data());
  //         }
  //         return;
  //       },
  //     );
  //     notifyListeners();
  //   } else {
  //     String capitalizedValue = value.substring(0, 1).toUpperCase() + value.substring(1);
  //     tempSearchStore = [];
  //     queryResultSet.forEach((element) {
  //       if (element['user_name'].startsWith(capitalizedValue)) {
  //         tempSearchStore.add(element);
  //       }
  //     });
  //     notifyListeners();
  //   }
  // }
}
