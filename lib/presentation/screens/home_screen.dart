import 'package:chat_mingle/presentation/screens/chat_screen.dart';
import 'package:chat_mingle/presentation/utils/custom_size.dart';
import 'package:chat_mingle/presentation/widgets/message_card.dart';
import 'package:chat_mingle/presentation/widgets/search_text_field.dart';
import 'package:chat_mingle/provider/home_notifier.dart';
import 'package:chat_mingle/theme/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeNotifier>(context, listen: false).getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Consumer<HomeNotifier>(builder: (context, notifier, _) {
              return Padding(
                padding: notifier.isSearching
                    ? const EdgeInsets.symmetric(horizontal: 20, vertical: 18)
                    : const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
            }),
            Expanded(
              child: Consumer<HomeNotifier>(builder: (context, notifier, _) {
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
                  child: notifier.isSearching
                      ? ListView.separated(
                          primary: false,
                          itemBuilder: (context, index) {
                            return Visibility(
                              visible: FirebaseAuth.instance.currentUser!.uid != notifier.foundedUsers[index].uid,
                              child: MessageCard(
                                user: notifier.foundedUsers[index],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => CustomSize.height40,
                          itemCount: notifier.foundedUsers.length)
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            return Visibility(
                              visible: FirebaseAuth.instance.currentUser!.uid != notifier.allUsers[index].uid,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ChatScreen(),
                                    ),
                                  );
                                },
                                child: MessageCard(user: notifier.allUsers[index]),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => CustomSize.height40,
                          itemCount: notifier.allUsers.length,
                        ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
