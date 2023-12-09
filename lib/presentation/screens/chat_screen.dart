import 'package:chat_mingle/models/user_model.dart';
import 'package:chat_mingle/presentation/utils/custom_size.dart';
import 'package:chat_mingle/presentation/widgets/chat_card.dart';
import 'package:chat_mingle/presentation/widgets/chat_text_field_box.dart';
import 'package:chat_mingle/provider/chat_notifier.dart';
import 'package:chat_mingle/provider/shared_pref_notifier.dart';
import 'package:chat_mingle/theme/custom_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.user, required this.chatRoomId});
  final UserModel user;
  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ChatNotifier>(context, listen: false).getMessageStream(chatRoomId: chatRoomId);
    });
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: CustomColors.primaryLightColor,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      user.photoUrl,
                      height: 35,
                      width: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                  CustomSize.width15,
                  SizedBox(
                    width: screenWidth / 2,
                    child: Text(
                      user.name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18).copyWith(bottom: 22),
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Consumer<ChatNotifier>(
                  builder: (context, notifier, _) {
                    return Column(
                      children: [
                        Expanded(
                          child: StreamBuilder(
                            stream: notifier.messageStream,
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator.adaptive(
                                      strokeWidth: 3,
                                    ),
                                  ),
                                );
                              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No Chats',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                );
                              }
                              return ListView.separated(
                                reverse: true,
                                itemBuilder: (context, index) {
                                  QueryDocumentSnapshot<Map<String, dynamic>> snap = snapshot.data!.docs[index];
                                  return ChatCard(snap: snap);
                                },
                                separatorBuilder: (context, index) => CustomSize.height5,
                                itemCount: snapshot.data!.docs.length,
                              );
                            },
                          ),
                        ),
                        CustomSize.height15,
                        Consumer<SharedPrefNotifier>(
                          builder: (context, sharedPrefNotifer, _) {
                            return ChatTextFieldBox(
                              currentUserName: sharedPrefNotifer.currentUser['user_name'],
                              currentUserProfPic: sharedPrefNotifer.currentUser['prof_pic'],
                              user: user,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
