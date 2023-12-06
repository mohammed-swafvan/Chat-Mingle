import 'package:chat_mingle/models/user_model.dart';
import 'package:chat_mingle/presentation/utils/utils.dart';
import 'package:chat_mingle/services/firestore_services.dart';
import 'package:chat_mingle/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> register(
      {required BuildContext context, required String name, required String email, required String password}) async {
    String result = "";
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      String id = randomAlphaNumeric(10);
      UserModel userModel = UserModel(
        uid: id,
        name: name,
        email: email,
        userName: email.replaceAll('@gmail.com', ''),
        photoUrl:
            "https://static.vecteezy.com/system/resources/thumbnails/024/095/208/small/happy-young-man-smiling-free-png.png",
      );
      await FirestoreServices().addUserDetails(userDetails: userModel);
      await SharedPrefernceHelper().saveUserId(userModel.uid);
      await SharedPrefernceHelper().saveUserEmail(userModel.email);
      await SharedPrefernceHelper().saveUserName(userModel.userName);
      await SharedPrefernceHelper().saveUserDisplayName(userModel.name);
      await SharedPrefernceHelper().saveUserPic(userModel.photoUrl);
      result = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (context.mounted) {
          Utils().customSnackBar(context: context, content: 'Password provided is too weak');
        }
      } else if (e.code == 'email-already-in-use') {
        if (context.mounted) {
          Utils().customSnackBar(context: context, content: 'Account already exists');
        }
      }
    }
    return result;
  }
}
