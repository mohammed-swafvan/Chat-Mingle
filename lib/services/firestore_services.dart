import 'package:chat_mingle/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addUserDetails({required UserModel userDetails}) async {
    try {
      await firestore.collection('user').doc(userDetails.uid).set(
            userDetails.toJson(),
          );
    } catch (e) {
      print(e.toString());
    }
  }
}
