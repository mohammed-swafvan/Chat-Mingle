import 'package:chat_mingle/models/user_model.dart';
import 'package:chat_mingle/presentation/utils/utils.dart';
import 'package:chat_mingle/services/firestore_services.dart';
import 'package:chat_mingle/services/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> register(
      {required BuildContext context, required String name, required String email, required String password}) async {
    String result = "";
    String userName = email.replaceAll('@gmail.com', '');
    try {
      UserCredential cred = await auth.createUserWithEmailAndPassword(email: email, password: password);
      String uid = cred.user!.uid;
      UserModel userModel = UserModel(
        uid: uid,
        name: name,
        email: email,
        userName: userName,
        photoUrl:
            "https://static.vecteezy.com/system/resources/thumbnails/024/095/208/small/happy-young-man-smiling-free-png.png",
      );
      await SharedPrefernceHelper().saveUserId(userModel.uid);
      await SharedPrefernceHelper().saveUserEmail(userModel.email);
      await SharedPrefernceHelper().saveUserName(userModel.userName);
      await SharedPrefernceHelper().saveUserDisplayName(userModel.name);
      await SharedPrefernceHelper().saveUserPic(userModel.photoUrl);
      if (context.mounted) {
        await FirestoreServices().addUserDetails(context: context, userDetails: userModel);
      }
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
      } else {
        if (context.mounted) {
          Utils().customSnackBar(context: context, content: e.code);
        }
      }
    }
    return result;
  }

  Future<String> userLogin({required BuildContext context, required String email, required String password}) async {
    String result = '';
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      QuerySnapshot querySnapshot = await FirestoreServices().getUserByEmail(email);
      String uid = querySnapshot.docs[0]['uid'];
      String name = querySnapshot.docs[0]['name'];
      String userName = querySnapshot.docs[0]['user_name'];
      String photoUrl = querySnapshot.docs[0]['photo_url'];
      await SharedPrefernceHelper().saveUserId(uid);
      await SharedPrefernceHelper().saveUserEmail(email);
      await SharedPrefernceHelper().saveUserName(userName);
      await SharedPrefernceHelper().saveUserDisplayName(name);
      await SharedPrefernceHelper().saveUserPic(photoUrl);
      result = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (context.mounted) {
          Utils().customSnackBar(context: context, content: 'No user four for the email');
        }
      } else if (e.code == 'wrong-password') {
        if (context.mounted) {
          Utils().customSnackBar(context: context, content: 'Password is incorrect');
        }
      } else {
        if (context.mounted) {
          Utils().customSnackBar(context: context, content: e.code);
        }
      }
    }
    return result;
  }

  Future<String> resetPassword({required BuildContext context, required String email}) async {
    String result = '';
    try {
      await auth.sendPasswordResetEmail(email: email);
      result = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (context.mounted) {
          Utils().customSnackBar(context: context, content: 'No user found for that email');
        }
      }
    }
    return result;
  }
}
