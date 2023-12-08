import 'package:cloud_firestore/cloud_firestore.dart';

class LastMessageModel {
  LastMessageModel({
    required this.lastMessage,
    required this.lastmessageSendBy,
    required this.lastMessageFormatedDate,
    required this.lastMessageTime,
  });

  final String lastMessage;
  final String lastmessageSendBy;
  final String lastMessageFormatedDate;
  final FieldValue lastMessageTime;

  Map<String, dynamic> toJson() => {
        'lastmessage': lastMessage,
        'lastmessage_sendby': lastmessageSendBy,
        'lastmessage_formatedtime': lastMessageFormatedDate,
        'lastmessage_time': lastMessageTime,
      };
}
