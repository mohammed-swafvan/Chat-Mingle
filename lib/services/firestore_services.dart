import 'package:chat_mingle/models/last_message_model.dart';
import 'package:chat_mingle/models/message_model.dart';
import 'package:chat_mingle/models/user_model.dart';
import 'package:chat_mingle/presentation/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getUserByEmail(String email) async {
    return firestore.collection('user').where('email', isEqualTo: email).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    return firestore.collection('user').get();
  }

  Future<void> addUserDetails({required BuildContext context, required UserModel userDetails}) async {
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

  Future<void> createChatRoom({required String chatRoomId, required Map<String, dynamic> chatRoomInfoMap}) async {
    DocumentSnapshot snapshot = await firestore.collection('chatroom').doc(chatRoomId).get();
    if (!snapshot.exists) {
      await firestore.collection('chatroom').doc(chatRoomId).set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMeassages({required String chatRoomId}) async {
    return firestore.collection('chatroom').doc(chatRoomId).collection('chats').orderBy("time", descending: true).snapshots();
  }

  Future<void> addMessage({required String chatRoomId, required MessageModel messageInfo}) async {
    await firestore.collection('chatroom').doc(chatRoomId).collection('chats').doc(messageInfo.messageId).set(
          messageInfo.toJson(),
        );
  }

  Future<void> updateLastMessage({required String chatRoomId, required LastMessageModel lastMessageInfo}) async {
    await firestore.collection('chatroom').doc(chatRoomId).update(lastMessageInfo.toJson());
  }
}
