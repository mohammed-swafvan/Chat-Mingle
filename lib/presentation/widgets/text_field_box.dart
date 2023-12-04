import 'package:chat_mingle/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class TextFieldBox extends StatelessWidget {
  const TextFieldBox({super.key, required this.icon, required this.hintText});
  final IconData icon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Colors.black38),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: CustomColors.primaryColor),
        ),
        obscureText: hintText == "Password" ? true : false,
      ),
    );
  }
}
