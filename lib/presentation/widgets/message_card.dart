import 'package:chat_mingle/models/user_model.dart';
import 'package:chat_mingle/presentation/utils/custom_size.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Image.network(
            "https://static.vecteezy.com/system/resources/thumbnails/024/095/208/small/happy-young-man-smiling-free-png.png",
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
                child: Text(
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
                        color: Theme.of(context).brightness == Brightness.light ? Colors.black38 : Colors.white54,
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
    );
  }
}
