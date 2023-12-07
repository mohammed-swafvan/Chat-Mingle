import 'package:chat_mingle/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class TextFieldBox extends StatelessWidget {
  const TextFieldBox({
    super.key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.isVibleOff = false,
    this.visibleButtonTap,
  });
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final bool isVibleOff;
  final void Function()? visibleButtonTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Colors.black38),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null && value!.isEmpty) {
                  return 'Fields is required';
                }
                return null;
              },
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                errorStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.red),
                hintText: hintText,
                border: InputBorder.none,
                prefixIcon: Icon(icon, color: CustomColors.primaryColor),
              ),
              obscureText: isVibleOff,
            ),
          ),
          Visibility(
            visible: hintText == 'Password' || hintText == 'Confirm Password',
            child: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: InkWell(
                onTap: visibleButtonTap,
                child: Icon(
                  isVibleOff ? Icons.visibility_off : Icons.visibility,
                  color: Colors.deepPurple.withOpacity(0.4),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
