import 'package:chat_mingle/models/user_model.dart';
import 'package:chat_mingle/presentation/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getUserByEmail(String email) async {
    return firestore.collection('user').where('email', isEqualTo: email).get();
  }

  addUserDetails({required BuildContext context, required UserModel userDetails}) async {
    try {
      await firestore.collection('user').doc(userDetails.uid).set(
            userDetails.toJson(),
          );
    } catch (e) {
      if (context.mounted) {
        Utils().customSnackBar(context: context, content: e.toString());
      }
    }
  }
}
