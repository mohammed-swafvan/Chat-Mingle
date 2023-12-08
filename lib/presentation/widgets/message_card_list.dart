import 'package:chat_mingle/models/user_model.dart';
import 'package:chat_mingle/presentation/screens/chat_screen.dart';
import 'package:chat_mingle/presentation/utils/custom_size.dart';
import 'package:chat_mingle/provider/home_notifier.dart';
import 'package:chat_mingle/theme/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageCardList extends StatelessWidget {
  const MessageCardList({super.key, required this.userModelList});
  final List<UserModel> userModelList;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return userModelList.isEmpty
        ? Center(
            child: Text(
              'No User Found',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              UserModel user = userModelList[index];
              return Material(
                elevation: 6.0,
                borderRadius: BorderRadius.circular(12),
                shadowColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.grey.shade500,
                child: Consumer<HomeNotifier>(
                  builder: (context, notifier, _) {
                    return InkWell(
                      onTap: () {
                        notifier.isSearching = false;
                        notifier.foundedUsers.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(user: user),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: CustomColors.primaryLightColor.withOpacity(0.2),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                user.photoUrl,
                                height: 65,
                                width: 65,
                                fit: BoxFit.cover,
                              ),
                            ),
                            CustomSize.width10,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: screenWidth / 2.5,
                                    child: user.uid == FirebaseAuth.instance.currentUser!.uid
                                        ? Wrap(
                                            spacing: 6,
                                            children: [
                                              Text(
                                                user.userName,
                                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                              ),
                                              Text(
                                                "(You)",
                                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      overflow: TextOverflow.ellipsis,
                                                      color: CustomColors.primaryLightColor,
                                                    ),
                                              ),
                                            ],
                                          )
                                        : Text(
                                            user.userName,
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                          ),
                                  ),
                                  SizedBox(
                                    width: screenWidth / 2.2,
                                    child: Text(
                                      'Hey, what are you doing?',
                                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).brightness == Brightness.light
                                                ? Colors.black38
                                                : Colors.white54,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '04:00 PM',
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness == Brightness.light ? Colors.black38 : Colors.white54,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => CustomSize.height20,
            itemCount: userModelList.length,
          );
  }
}
