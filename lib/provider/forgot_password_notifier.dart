import 'package:chat_mingle/presentation/utils/utils.dart';
import 'package:chat_mingle/services/auth_services.dart';
import 'package:flutter/material.dart';

class ForgotPasswordNotifier extends ChangeNotifier {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  Future resetPassword({required BuildContext context, required String email}) async {
    isLoading = true;
    notifyListeners();

    if (email.length < 10) {
      emailController.clear();
      isLoading = false;
      notifyListeners();
      if (context.mounted) {
        return Utils().customSnackBar(context: context, content: 'Email is not a valid email');
      }
    }

    String emailValidation = email.substring(email.length - 10);
    if (emailValidation != "@gmail.com" || email.length < 13) {
      emailController.clear();
      isLoading = false;
      notifyListeners();
      if (context.mounted) {
        return Utils().customSnackBar(context: context, content: 'Email is not a valid email');
      }
    }

    String result = await AuthServices().resetPassword(context: context, email: email);
    if (result == 'success') {
      if (context.mounted) {
        emailController.clear();
        isLoading = false;
        notifyListeners();
        return Utils().customSnackBar(context: context, content: 'Password reset email has been sent');
      }
    } else {
      if (context.mounted) {
        isLoading = false;
        emailController.clear();
        notifyListeners();
        return Utils().customSnackBar(context: context, content: 'Something went wrong');
      }
    }
  }
}
