import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  MessageModel({
    required this.message,
    required this.sendBy,
    required this.formatedTime,
    required this.time,
    required this.imageUrl,
    required this.messageId,
  });

  final String message;
  final String sendBy;
  final String formatedTime;
  final FieldValue time;
  final String imageUrl;
  final String messageId;

  Map<String, dynamic> toJson() => {
        'message': message,
        'send_by': sendBy,
        'formated_time': formatedTime,
        'time': time,
        "image_url": imageUrl,
        "message_id": messageId,
      };
}
