import 'package:chat_mingle/models/last_message_model.dart';
import 'package:chat_mingle/models/message_model.dart';
import 'package:chat_mingle/models/user_model.dart';
import 'package:chat_mingle/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class ChatNotifier extends ChangeNotifier {
  final TextEditingController messageController = TextEditingController();
  Stream? messageStream;

  getMessageStream({required String chatRoomId}) async {
    messageStream = await FirestoreServices().getChatRoomMeassages(chatRoomId: chatRoomId);
    notifyListeners();
  }

  Future<void> addMessage(
      {required String message, required String currentUserName, required String profPic, required UserModel user}) async {
    if (message.isNotEmpty) {
      messageController.text = "";
      DateTime currentTime = DateTime.now();
      String formatedTime = DateFormat('h:mma').format(currentTime);
      String messageId = randomAlphaNumeric(10);
      MessageModel messageInfo = MessageModel(
        message: message,
        sendBy: currentUserName,
        formatedTime: formatedTime,
        time: FieldValue.serverTimestamp(),
        imageUrl: profPic,
        messageId: messageId,
      );
      String chatRoomId = getChatRoomIdByUserName(chatingUserName: user.userName, currentUserName: currentUserName);
      await FirestoreServices().addMessage(chatRoomId: chatRoomId, messageInfo: messageInfo).then(
        (value) async {
          LastMessageModel lastMessageInfo = LastMessageModel(
            lastMessage: message,
            lastmessageSendBy: currentUserName,
            lastMessageFormatedDate: formatedTime,
            lastMessageTime: FieldValue.serverTimestamp(),
          );
          await FirestoreServices().updateLastMessage(chatRoomId: chatRoomId, lastMessageInfo: lastMessageInfo);
        },
      );
    }
  }

  String getChatRoomIdByUserName({required String chatingUserName, required String currentUserName}) {
    if (chatingUserName.substring(0, 1).codeUnitAt(0) > currentUserName.substring(0, 1).codeUnitAt(0)) {
      return "${currentUserName}_$chatingUserName";
    } else {
      return "${chatingUserName}_$currentUserName";
    }
  }
}
