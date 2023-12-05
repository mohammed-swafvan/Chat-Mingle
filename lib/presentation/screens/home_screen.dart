import 'package:chat_mingle/presentation/screens/chat_screen.dart';
import 'package:chat_mingle/presentation/utils/custom_size.dart';
import 'package:chat_mingle/presentation/widgets/message_card.dart';
import 'package:chat_mingle/theme/custom_colors.dart';
import 'package:flutter/material.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ChatMingle',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: CustomColors.iconBackgroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.search_rounded,
                      color: CustomColors.primaryLightColor,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatScreen(),
                          ),
                        );
                      },
                      child: const MessageCard(),
                    );
                  },
                  separatorBuilder: (context, index) => CustomSize.height40,
                  itemCount: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
