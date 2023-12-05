import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    late BoxDecoration boxDecoration;
    late EdgeInsetsGeometry boxMargin;
    late AlignmentGeometry textAlign;

    if (index % 2 == 0) {
      boxDecoration = BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light ? const Color.fromARGB(31, 169, 168, 168) : Colors.grey.shade300,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(0),
          bottomLeft: Radius.circular(12),
        ),
      );
      boxMargin = EdgeInsets.only(left: screenWidth / 3);
      textAlign = Alignment.bottomRight;
    } else {
      boxDecoration = const BoxDecoration(
        color: Color.fromARGB(255, 235, 221, 239),
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 221, 203, 242), Color.fromARGB(255, 207, 214, 243)],
          begin: Alignment.topLeft,
          end: AlignmentDirectional.bottomEnd,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
          bottomLeft: Radius.circular(0),
        ),
      );
      boxMargin = EdgeInsets.only(right: screenWidth / 3);
      textAlign = Alignment.bottomLeft;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      alignment: textAlign,
      margin: boxMargin,
      decoration: boxDecoration,
      child: Text(
        "Hello, How was the Day?",
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
