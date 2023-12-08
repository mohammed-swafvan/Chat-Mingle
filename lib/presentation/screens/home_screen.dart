import 'package:chat_mingle/presentation/widgets/message_card_list.dart';
import 'package:chat_mingle/presentation/widgets/search_text_field.dart';
import 'package:chat_mingle/provider/home_notifier.dart';
import 'package:chat_mingle/provider/shared_pref_notifier.dart';
import 'package:chat_mingle/services/auth_services.dart';
import 'package:chat_mingle/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Consumer<HomeNotifier>(
              builder: (context, notifier, _) {
                return Padding(
                  padding: notifier.isSearching
                      ? const EdgeInsets.symmetric(horizontal: 20, vertical: 18)
                      : const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          AuthServices().signOutUser(context);
                        },
                        child: Consumer<SharedPrefNotifier>(builder: (context, sharedPrefNotifer, _) {
                          return SizedBox(
                            width: 32,
                            height: 32,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                sharedPrefNotifer.currentUser['prof_pic'],
                                height: 32,
                                width: 32,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                      ),
                      notifier.isSearching
                          ? const SearchTextField()
                          : Text(
                              'ChatMingle',
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                            ),
                      InkWell(
                        onTap: () {
                          notifier.changeSearchVisibility();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: CustomColors.iconBackgroundColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            notifier.isSearching ? Icons.close : Icons.search_rounded,
                            color: CustomColors.primaryLightColor,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            Expanded(
              child: Consumer<HomeNotifier>(
                builder: (context, notifier, _) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: notifier.isSearching && notifier.foundedUsers.isNotEmpty
                        ? MessageCardList(userModelList: notifier.foundedUsers)
                        : MessageCardList(userModelList: notifier.allUsers),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
