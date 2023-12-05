import 'package:chat_mingle/presentation/utils/custom_size.dart';
import 'package:chat_mingle/presentation/widgets/chat_card.dart';
import 'package:chat_mingle/presentation/widgets/chat_text_field_box.dart';
import 'package:chat_mingle/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      "https://static.vecteezy.com/system/resources/thumbnails/024/095/208/small/happy-young-man-smiling-free-png.png",
                      height: 35,
                      width: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                  CustomSize.width10,
                  SizedBox(
                    width: screenWidth / 2,
                    child: Text(
                      'Swafvan',
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
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ChatCard(index: index);
                        },
                        separatorBuilder: (context, index) => CustomSize.height15,
                        itemCount: 20,
                      ),
                    ),
                    CustomSize.height5,
                    const ChatTextFieldBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}