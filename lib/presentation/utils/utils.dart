import 'package:flutter/material.dart';

class Utils {
  customSnackBar({required BuildContext context, required String content}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
