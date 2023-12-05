import 'package:flutter/material.dart';

class ChatTextFieldBox extends StatelessWidget {
  const ChatTextFieldBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6.0,
      shadowColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.grey.shade300,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade900,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Text a meassage...",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Icon(
              Icons.send,
              color: Color.fromARGB(255, 175, 175, 175),
            ),
          ],
        ),
      ),
    );
  }
}
