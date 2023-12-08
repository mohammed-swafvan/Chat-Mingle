import 'package:chat_mingle/models/user_model.dart';
import 'package:chat_mingle/provider/chat_notifier.dart';
import 'package:chat_mingle/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatTextFieldBox extends StatelessWidget {
  const ChatTextFieldBox({super.key, required this.currentUserName, required this.currentUserProfPic, required this.user});
  final String currentUserName;
  final String currentUserProfPic;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6.0,
      shadowColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.grey.shade300,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade900,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Consumer<ChatNotifier>(builder: (context, notifier, _) {
          return Row(
            children: [
              Expanded(
                child: TextField(
                  controller: notifier.messageController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Text a meassage...",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await notifier.addMessage(
                    message: notifier.messageController.text,
                    currentUserName: currentUserName,
                    profPic: currentUserProfPic,
                    user: user,
                  );
                },
                child: const Icon(
                  Icons.send,
                  color: CustomColors.primaryLightColor,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
